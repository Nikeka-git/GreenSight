import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/auth/local_user_service.dart';
import '../core/location/location_service.dart';
import '../core/network/connectivity_service.dart';
import '../core/services/sync_service.dart';
import '../data/local/database.dart';
import '../data/remote/api/greensight_api_client.dart';
import '../data/repositories/tree_repository_impl.dart';
import '../data/repositories/work_request_repository_impl.dart';
import '../domain/models/work_request.dart';
import '../domain/repositories/repositories.dart';

/// Backend API base URL. Override at build/run time with
const String apiBaseUrl = String.fromEnvironment(
  'API_URL',
  defaultValue: 'http://192.168.0.110:3000',
);

// ===== SINGLETONS =====

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final localUserServiceProvider = Provider<LocalUserService>((ref) {
  return LocalUserService();
});

final locationServiceProvider = Provider<LocationService>((ref) {
  return LocationService();
});

final apiClientProvider = Provider<GreensightApiClient>((ref) {
  return GreensightApiClient(baseUrl: apiBaseUrl);
});

// ===== REPOSITORIES =====

final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return TreeRepositoryImpl(db);
});

final workRequestRepositoryProvider = Provider<WorkRequestRepository>((ref) {
  final db = ref.watch(databaseProvider);
  return WorkRequestRepositoryImpl(db);
});

// ===== SYNC SERVICE =====

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    connectivity: ref.watch(connectivityServiceProvider),
    workRequestRepo: ref.watch(workRequestRepositoryProvider),
    apiClient: ref.watch(apiClientProvider),
    localUserService: ref.watch(localUserServiceProvider),
  );
  service.start();
  ref.onDispose(service.dispose);
  return service;
});

// ===== STREAMS ДЛЯ UI =====

final myRequestsProvider = StreamProvider.autoDispose<List<WorkRequest>>((ref) async* {
  final userId = await ref.watch(localUserServiceProvider).getUserId();
  yield* ref.watch(workRequestRepositoryProvider).watchByUser(userId);
});
