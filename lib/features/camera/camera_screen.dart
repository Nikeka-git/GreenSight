import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../core/location/location_service.dart';
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

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      // Получаем список доступных камер
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        _showError('Камера не найдена');
        return;
      }
      // Берём заднюю камеру (или первую)
      final camera = cameras.firstWhere(
            (c) => c.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );
      _controller = CameraController(camera, ResolutionPreset.medium, enableAudio: false);
      _initializeControllerFuture = _controller!.initialize();
      await _initializeControllerFuture;
      if (mounted) {
        setState(() => _isCameraReady = true);
      }
    } catch (e) {
      _showError('Ошибка инициализации камеры: $e');
    }
  }

  void _showError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _takePhoto() async {
    if (!_isCameraReady || _controller == null) return;

    try {
      // Делаем снимок
      final XFile image = await _controller!.takePicture();

      // Получаем геолокацию
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
              backgroundColor: Colors.orange,
            ),
          );
        }
        latitude = 0.0;
        longitude = 0.0;
      }

      // Переходим на экран описания проблемы
      if (mounted) {
        Navigator.push(
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
      appBar: AppBar(title: const Text('Сфотографировать дерево')),
      body: Stack(
        children: [
          // Предпросмотр камеры
          if (_isCameraReady && _controller != null)
            CameraPreview(_controller!)
          else
            const Center(child: CircularProgressIndicator()),

          // Кнопка съёмки (внизу по центру)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _takePhoto,
                backgroundColor: Colors.white,
                child: const Icon(Icons.camera_alt, color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}