import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/permissions/permission_service.dart';
import '../../providers/providers.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _isLoading = true;
  String _statusMessage = 'Проверка разрешений...';

  @override
  void initState() {
    super.initState();
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    final permissionService = ref.read(permissionServiceProvider);
    bool hasPermissions = await permissionService.checkPermissions();

    if (hasPermissions) {
      // Если разрешения есть – переходим на камеру
      _navigateToCamera();
      return;
    }

    // Если нет – запрашиваем
    setState(() {
      _statusMessage = 'Запрос разрешений...';
    });

    bool granted = await permissionService.requestPermissions();

    if (granted) {
      _navigateToCamera();
    } else {
      // Если разрешения не даны – показываем диалог
      setState(() {
        _isLoading = false;
        _statusMessage = 'Для работы приложения необходимы разрешения';
      });
    }
  }

  void _navigateToCamera() {
    if (mounted) {
      context.go('/camera');
    }
  }

  Future<void> _retry() async {
    setState(() {
      _isLoading = true;
      _statusMessage = 'Повторный запрос разрешений...';
    });
    final permissionService = ref.read(permissionServiceProvider);
    bool granted = await permissionService.requestPermissions();
    if (granted) {
      _navigateToCamera();
    } else {
      setState(() {
        _isLoading = false;
        _statusMessage = 'Для работы приложения необходимы разрешения';
      });
    }
  }

  Future<void> _openSettings() async {
    final permissionService = ref.read(permissionServiceProvider);
    await permissionService.openAppSettings();
    // После возврата из настроек проверяем снова
    await _checkPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.photo_camera,
                size: 80,
                color: Colors.green,
              ),
              const SizedBox(height: 20),
              const Text(
                'GreenSight',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40),
              if (_isLoading) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(_statusMessage),
              ] else ...[
                Text(
                  _statusMessage,
                  style: const TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _retry,
                      child: const Text('Повторить'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: _openSettings,
                      child: const Text('Настройки'),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}