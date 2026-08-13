import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/network/connectivity_service.dart';
import '../core/services/sync_service.dart';
import '../core/auth/local_user_service.dart';
import '../core/location/location_service.dart';
import '../data/local/database.dart';
import '../data/remote/ai/ai_api_client.dart';
import '../data/remote/s3/imgbb_upload_service.dart';
import '../data/repositories/tree_repository_impl.dart';
import '../data/repositories/work_request_repository_impl.dart';
import '../domain/models/work_request.dart';
import '../domain/repositories/repositories.dart';

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

final uploadServiceProvider = Provider<ImgBBUploadService>((ref) {
  return ImgBBUploadService(apiKey: 'ваш_ключ_заглушка');
});

final aiApiClientProvider = Provider<AiApiClient>((ref) {
  return AiApiClient.create(
    baseUrl: 'https://ai.greensight.example.kz/api/v1',
  );
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
    treeRepo: ref.watch(treeRepositoryProvider),
    aiClient: ref.watch(aiApiClientProvider),
    uploadService: ref.watch(uploadServiceProvider),
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