import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../core/location/location_service.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/decor.dart';
import '../problem_description/problem_description_screen.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen> {
  CameraController? _controller;
  Future<void>? _initializeControllerFuture;
  bool _isCameraReady = false;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _showError('Камера не найдена');
        return;
      }
      final camera = cameras.firstWhere(
        (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller =
          CameraController(camera, ResolutionPreset.medium, enableAudio: false);
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      if (mounted) setState(() => _isCameraReady = true);
    } catch (e) {
      _showError('Ошибка инициализации камеры: $e');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: AppColors.rust),
      );
    }
  }

  Future<void> _takePhoto() async {
    if (!_isCameraReady || _controller == null || _isCapturing) return;
    setState(() => _isCapturing = true);

    try {
      final XFile image = await _controller!.takePicture();

      final locationService = ref.read(locationServiceProvider);
      final locationData = await locationService.getCurrentLocation();

      double latitude, longitude;
      if (locationData != null) {
        latitude = locationData.latitude ?? 0.0;
        longitude = locationData.longitude ?? 0.0;
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Не удалось получить геолокацию. Координаты = 0'),
              backgroundColor: AppColors.amber,
            ),
          );
        }
        latitude = 0.0;
        longitude = 0.0;
      }

      if (mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProblemDescriptionScreen(
              photoFile: File(image.path),
              latitude: latitude,
              longitude: longitude,
            ),
          ),
        );
      }
    } catch (e) {
      _showError('Ошибка при съёмке: $e');
    } finally {
      if (mounted) setState(() => _isCapturing = false);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bark,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: AppColors.birch,
        elevation: 0,
        flexibleSpace: IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
          ),
        ),
        title: Text(
          'Сфотографировать дерево',
          style: AppTypography.textTheme.headlineSmall
              ?.copyWith(color: AppColors.birch, fontSize: 18),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (_isCameraReady && _controller != null)
            FittedBox(
              fit: BoxFit.cover,
              child: SizedBox(
                width: _controller!.value.previewSize?.height ?? 1,
                height: _controller!.value.previewSize?.width ?? 1,
                child: CameraPreview(_controller!),
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(color: AppColors.amber),
            ),

          // Затемнение сверху/снизу для читаемости UI поверх видоискателя
          if (_isCameraReady)
            IgnorePointer(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black38, Colors.transparent, Colors.black54],
                    stops: [0.0, 0.35, 1.0],
                  ),
                ),
              ),
            ),

          if (_isCameraReady)
            Builder(
              builder: (context) {
                final topInset = MediaQuery.of(context).padding.top +
                    kToolbarHeight +
                    18;
                return ViewfinderCorners(
                  color: Colors.white70,
                  padding: EdgeInsets.fromLTRB(28, topInset, 28, 28),
                );
              },
            ),

          // Подсказка над кнопкой съёмки
          Positioned(
            left: 0,
            right: 0,
            bottom: 148,
            child: Center(
              child: Text(
                'Наведите камеру на дерево так, чтобы\nствол и крона были видны целиком',
                textAlign: TextAlign.center,
                style: AppTypography.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.85),
                  height: 1.35,
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 44,
            left: 0,
            right: 0,
            child: Center(
              child: GestureDetector(
                onTap: _takePhoto,
                child: Container(
                  width: 76,
                  height: 76,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withValues(alpha: 0.14),
                    border: Border.all(color: Colors.white, width: 2.4),
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isCapturing ? AppColors.amber : Colors.white,
                    ),
                    child: _isCapturing
                        ? const Padding(
                            padding: EdgeInsets.all(18),
                            child: CircularProgressIndicator(
                              strokeWidth: 2.4,
                              color: AppColors.ink,
                            ),
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
