import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;

class LocationService {
  final Location _location = Location();

  Future<LocationData?> getCurrentLocation() async {
    // Проверяем, включена ли геолокация на устройстве
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }

    // Запрашиваем разрешение через permission_handler
    permission.PermissionStatus permissionStatus = await permission.Permission.location.request();
    if (permissionStatus.isDenied) {
      // Если отклонено, пробуем запросить повторно
      permissionStatus = await permission.Permission.location.request();
      if (permissionStatus.isDenied) {
        return null;
      }
    }
    if (permissionStatus.isPermanentlyDenied) {
      return null;
    }

    try {
      final LocationData locationData = await _location.getLocation();
      return locationData;
    } catch (e) {
      return null;
    }
  }
}