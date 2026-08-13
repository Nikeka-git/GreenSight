import 'dart:async';
import 'dart:io';

import '../../data/remote/api/greensight_api_client.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/work_request.dart';
import '../../domain/repositories/repositories.dart';
import '../auth/local_user_service.dart';
import '../network/connectivity_service.dart';

/// Pushes local work requests to the GreenSight backend and pulls the user's
/// server state back so local rows reflect AI verdicts / moderation decisions.
class SyncService {
  SyncService({
    required this.connectivity,
    required this.workRequestRepo,
    required this.apiClient,
    required this.localUserService,
  });

  final ConnectivityService connectivity;
  final WorkRequestRepository workRequestRepo;
  final GreensightApiClient apiClient;
  final LocalUserService localUserService;

  Timer? _syncTimer;
  bool _isSyncing = false;
  StreamSubscription<bool>? _connectivitySubscription;

  void start() {
    _connectivitySubscription = connectivity.onStatusChange.listen((isOnline) {
      if (isOnline) _scheduleSync();
    });
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) => _scheduleSync());
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _syncTimer?.cancel();
  }

  void _scheduleSync() {
    if (!_isSyncing) _sync();
  }

  Future<void> _sync() async {
    if (_isSyncing) return;
    _isSyncing = true;
    try {
      if (!await connectivity.isOnline) return;
      await _push();
      await _pull();
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _push() async {
    final pending = await workRequestRepo.getPendingSyncBatch(limit: 10);
    for (final request in pending) {
      try {
        await _pushRequest(request);
      } catch (e) {
        await _markFailed(request.id, e.toString());
      }
    }
  }

  Future<void> _pushRequest(WorkRequest request) async {
    // 1. Upload the photo if it isn't on the server yet.
    String? remotePhotoId = request.remotePhotoId;
    if (remotePhotoId == null) {
      final file = File(request.localPhotoPath);
      if (!await file.exists()) {
        throw ApiException('Фото не найдено: ${request.localPhotoPath}');
      }
      remotePhotoId = await apiClient.uploadPhoto(file);
      await workRequestRepo.update(request.copyWith(remotePhotoId: remotePhotoId));
    }

    // 2. Push the work request; the server runs AI analysis (status pendingAI).
    final pushed = request.copyWith(
      remotePhotoId: remotePhotoId,
      status: RequestStatus.pendingAI,
      syncAttempts: request.syncAttempts + 1,
      lastError: null,
    );
    await apiClient.createWorkRequest(payload: pushed.toApiPayload());
    await workRequestRepo.update(pushed);
  }

  Future<void> _pull() async {
    final userId = await localUserService.getUserId();
    final remote = await apiClient.fetchMyWorkRequests(userId);
    for (final json in remote) {
      final local = await workRequestRepo.getById(json['id'] as String);
      await workRequestRepo.update(
        WorkRequest.fromApiJson(
          json,
          localPhotoPath: local?.localPhotoPath ?? '',
        ),
      );
    }
  }

  Future<void> _markFailed(String requestId, String error) async {
    final request = await workRequestRepo.getById(requestId);
    if (request == null) return;
    await workRequestRepo.update(
      request.copyWith(
        status: RequestStatus.failed,
        syncAttempts: request.syncAttempts + 1,
        lastError: error,
        updatedAt: DateTime.now(),
      ),
    );
  }

  Future<void> syncNow() => _sync();
}
