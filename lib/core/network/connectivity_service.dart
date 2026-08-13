import 'package:connectivity_plus/connectivity_plus.dart';

/// Единая точка правды "есть сеть или нет" для всего приложения.
/// SyncService и UI (баннер "офлайн режим") подписываются на [onStatusChange].
class ConnectivityService {
  ConnectivityService() : _connectivity = Connectivity();
  final Connectivity _connectivity;

  Future<bool> get isOnline async {
    final results = await _connectivity.checkConnectivity();
    return _hasConnection(results);
  }

  Stream<bool> get onStatusChange =>
      _connectivity.onConnectivityChanged.map(_hasConnection);

  bool _hasConnection(List<ConnectivityResult> results) =>
      results.any((r) => r != ConnectivityResult.none);
}