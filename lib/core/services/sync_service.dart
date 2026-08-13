import 'dart:async';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import '../network/connectivity_service.dart';
import '../../data/remote/ai/ai_api_client.dart';
import '../../data/remote/ai/ai_result.dart';
import '../../data/remote/firebase/firestore_service.dart';
import '../../data/remote/firebase/photo_storage_service.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/tree.dart';
import '../../domain/models/work_request.dart';
import '../../domain/models/inspection.dart';
import '../../domain/repositories/repositories.dart';

class SyncService {
  SyncService({
    required this.connectivity,
    required this.workRequestRepo,
    required this.treeRepo,
    required this.aiClient,
    required this.photoStorage,
    required this.firestore,
    required this.auth,
  });

  final ConnectivityService connectivity;
  final WorkRequestRepository workRequestRepo;
  final TreeRepository treeRepo;
  final AiApiClient aiClient;
  final PhotoStorageService photoStorage;
  final FirestoreService firestore;
  final FirebaseAuth auth;

  Timer? _syncTimer;
  bool _isSyncing = false;
  StreamSubscription<bool>? _connectivitySubscription;

  void start() {
    _connectivitySubscription = connectivity.onStatusChange.listen((isOnline) {
      if (isOnline) {
        _scheduleSync();
      }
    });
    _syncTimer = Timer.periodic(
      const Duration(minutes: 5),
          (_) => _scheduleSync(),
    );
  }

  void dispose() {
    _connectivitySubscription?.cancel();
    _syncTimer?.cancel();
  }

  void _scheduleSync() {
    if (!_isSyncing) {
      _sync();
    }
  }

  Future<void> _sync() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      final isOnline = await connectivity.isOnline;
      if (!isOnline) return;

      final pending = await workRequestRepo.getPendingSyncBatch(limit: 10);
      if (pending.isEmpty) return;

      for (final request in pending) {
        try {
          await _processRequest(request);
        } catch (e, st) {
          await _markFailed(request.id, e.toString());
          // ignore: avoid_print
          print('Sync error: $e\n$st');
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> _processRequest(WorkRequest request) async {
    if (request.status == RequestStatus.draftLocal) {
      await workRequestRepo.update(
        request.copyWith(status: RequestStatus.pendingUpload),
      );
    }

    String? photoUrl = request.remotePhotoUrl;
    if (photoUrl == null || photoUrl.isEmpty) {
      final file = File(request.localPhotoPath);
      if (!await file.exists()) {
        throw Exception('Фото не найдено: ${request.localPhotoPath}');
      }
      photoUrl = await photoStorage.uploadTreePhoto(
        file: file,
        requestId: request.id,
      );
      await workRequestRepo.update(
        request.copyWith(
          remotePhotoUrl: photoUrl,
          status: RequestStatus.pendingAI,
        ),
      );
    }

    final aiResult = await aiClient.analyzePhoto(
      photo: File(request.localPhotoPath),
      latitude: request.latitude,
      longitude: request.longitude,
      userProblemCodes: request.userProblems.map((p) => p.name).toList(),
    );

    await _handleAiResult(request, aiResult, photoUrl);
  }

  Future<void> _handleAiResult(
      WorkRequest request,
      AiResult aiResult,
      String photoUrl,
      ) async {
    final updatedRequest = request.copyWith(
      aiCondition: aiResult.condition,
      aiConfidence: aiResult.confidence,
      status: aiResult.matchesUserReport
          ? RequestStatus.approved
          : RequestStatus.needsModeration,
      updatedAt: DateTime.now(),
    );
    await workRequestRepo.update(updatedRequest);

    if (aiResult.matchesUserReport) {
      await _createOrUpdateTree(request, aiResult, photoUrl);
    } else {
      await firestore.upsertWorkRequest(updatedRequest);
    }
  }

  Future<void> _createOrUpdateTree(
      WorkRequest request,
      AiResult aiResult,
      String photoUrl,
      ) async {
    final existingTree = await treeRepo.findNearbyDuplicate(
      request.latitude,
      request.longitude,
      radiusMeters: 5,
    );

    final now = DateTime.now();
    final treeLocalId =
        existingTree?.localId ?? 'tree_${now.millisecondsSinceEpoch}';

    Tree tree;
    if (existingTree != null) {
      tree = existingTree.copyWith(
        condition: aiResult.condition,
        status: aiResult.condition == TreeCondition.healthy
            ? TreeStatus.healthy
            : TreeStatus.needsWork,
        priority: aiResult.suggestedPriority,
        recommendation: aiResult.recommendation,
        lastInspectionDate: now,
        updatedAt: now,
        mainPhotoUrl: photoUrl,
      );
    } else {
      tree = Tree(
        localId: treeLocalId,
        latitude: request.latitude,
        longitude: request.longitude,
        category: TreeCategory.unknown,
        condition: aiResult.condition,
        status: aiResult.condition == TreeCondition.healthy
            ? TreeStatus.healthy
            : TreeStatus.needsWork,
        mainPhotoUrl: photoUrl,
        lastInspectionDate: now,
        recommendation: aiResult.recommendation,
        priority: aiResult.suggestedPriority,
        createdAt: now,
        updatedAt: now,
      );
    }

    await treeRepo.upsertTree(tree);

    final updatedRequest = request.copyWith(
      treeLocalId: tree.localId,
      status: RequestStatus.approved,
      updatedAt: now,
    );
    await workRequestRepo.update(updatedRequest);

    final inspection = Inspection(
      id: 'insp_${now.millisecondsSinceEpoch}',
      treeLocalId: tree.localId,
      photoUrl: photoUrl,
      aiCondition: aiResult.condition,
      aiConfidence: aiResult.confidence,
      inspectedAt: now,
      inspectorId: request.createdByUserId,
    );
    await treeRepo.addInspection(inspection);
  }

  Future<void> _markFailed(String requestId, String error) async {
    final pending = await workRequestRepo.getPendingSyncBatch(limit: 1000);
    final request = pending.where((r) => r.id == requestId).firstOrNull;
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