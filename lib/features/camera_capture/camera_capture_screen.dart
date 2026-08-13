import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/providers.dart';
import '../problem_description/problem_description_screen.dart';

class CameraCaptureScreen extends ConsumerStatefulWidget {
  const CameraCaptureScreen({super.key});

  @override
  ConsumerState<CameraCaptureScreen> createState() => _CameraCaptureScreenState();
}

class _CameraCaptureScreenState extends ConsumerState<CameraCaptureScreen> {
  bool _isLoading = false;

  Future<void> _takePhoto() async {
    setState(() => _isLoading = true);

    try {
      // 1. Получаем фото
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image == null) {
        setState(() => _isLoading = false);
        return;
      }

      // 2. Получаем координаты
      final locationService = ref.read(locationServiceProvider);
      final locationData = await locationService.getCurrentLocation();

      double latitude, longitude;
      if (locationData != null) {
        latitude = locationData.latitude ?? 0.0;
        longitude = locationData.longitude ?? 0.0;
      } else {
        // Если геолокация недоступна – показываем предупреждение и используем заглушку
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Не удалось получить геолокацию. Координаты будут установлены в 0.'),
              backgroundColor: Colors.orange,
            ),
          );
        }
        latitude = 0.0;
        longitude = 0.0;
      }

      // 3. Переходим на экран описания
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
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Сфотографировать дерево')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.photo_camera, size: 80, color: Colors.green),
            const SizedBox(height: 20),
            const Text('Нажмите кнопку, чтобы сфотографировать дерево',
                textAlign: TextAlign.center),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _takePhoto,
              icon: _isLoading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Icon(Icons.camera_alt),
              label: Text(_isLoading ? 'Загрузка...' : 'Сделать фото'),
            ),
          ],
        ),
      ),
    );
  }
}