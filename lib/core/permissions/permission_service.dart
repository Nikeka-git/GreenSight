import 'package:permission_handler/permission_handler.dart' as permission;

class PermissionService {
  /// Проверяет, даны ли все необходимые разрешения.
  Future<bool> checkPermissions() async {
    final cameraStatus = await permission.Permission.camera.status;
    final locationStatus = await permission.Permission.location.status;
    // Если нужно хранилище – добавить.
    return cameraStatus.isGranted && locationStatus.isGranted;
  }

  /// Запрашивает все необходимые разрешения.
  /// Возвращает true, если все даны.
  Future<bool> requestPermissions() async {
    // Запрашиваем камеру и геолокацию
    Map<permission.Permission, permission.PermissionStatus> statuses = await [
      permission.Permission.camera,
      permission.Permission.location,
    ].request();

    // Проверяем, что все даны
    bool allGranted = statuses.values.every((status) => status.isGranted);
    return allGranted;
  }

  /// Открывает настройки приложения (если разрешения запрещены навсегда)
  Future<void> openAppSettings() async {
    await permission.openAppSettings();
  }
}