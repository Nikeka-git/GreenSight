import 'package:drift/drift.dart' as drift;

import '../../domain/enums/domain_enums.dart';
import '../../domain/models/work_request.dart';
import '../../domain/repositories/repositories.dart';
import '../local/database.dart';
import '../local/tables/work_requests_table.dart';
import '../remote/firebase/firestore_service.dart';

class WorkRequestRepositoryImpl implements WorkRequestRepository {
  WorkRequestRepositoryImpl(this._db, this._firestore);

  final AppDatabase _db;
  final FirestoreService _firestore;

  @override
  Stream<List<WorkRequest>> watchAll() =>
      _db.workRequestDao.watchAll().map((r) => r.map(_fromRow).toList());

  @override
  Stream<List<WorkRequest>> watchByUser(String userId) => _db.workRequestDao
      .watchByUser(userId)
      .map((r) => r.map(_fromRow).toList());

  @override
  Stream<List<WorkRequest>> watchPendingModeration() => _db.workRequestDao
      .watchByStatus(RequestStatus.needsModeration.name)
      .map((r) => r.map(_fromRow).toList());

  @override
  Future<List<WorkRequest>> getPendingSyncBatch({int limit = 10}) async {
    final rows = await _db.workRequestDao.getPendingSyncBatch(limit: limit);
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> createLocal(WorkRequest request) async {
    // Пишем ТОЛЬКО в Drift — это ключевое требование офлайн-first: заявка
    // должна сохраниться мгновенно, без ожидания сети. Firestore получит
    // копию позже через SyncService.
    await _db.workRequestDao.insertOrUpdate(_toCompanion(request));
  }

  @override
  Future<void> update(WorkRequest request) async {
    await _db.workRequestDao.insertOrUpdate(_toCompanion(request));
    // Пишем в Firestore лучшим усилием — если сети нет, Firestore SDK сам
    // поставит операцию в свою внутреннюю офлайн-очередь и повторит позже.
    // Локальная очередь в Drift остаётся основным источником истины для UI.
    try {
      await _firestore.upsertWorkRequest(request);
    } catch (_) {
      // не блокируем локальный поток — SyncService повторит на след. тике
    }
  }

  @override
  Future<void> markModerationDecision({
    required String requestId,
    required bool approved,
  }) async {
    final rows = await _db.workRequestDao.getPendingSyncBatch(limit: 1000);
    final target = rows.where((r) => r.id == requestId).firstOrNull;
    if (target == null) return;
    final updated = _fromRow(target).copyWith(
      status: approved ? RequestStatus.approved : RequestStatus.rejected,
    );
    await update(updated);
  }

  WorkRequest _fromRow(WorkRequestsTableData r) => WorkRequest(
    id: r.id,
    treeLocalId: r.treeLocalId,
    localPhotoPath: r.localPhotoPath,
    remotePhotoUrl: r.remotePhotoUrl,
    latitude: r.latitude,
    longitude: r.longitude,
    userProblems: r.userProblemsCsv
        .split(',')
        .where((s) => s.isNotEmpty)
        .map((s) => ProblemType.values.byName(s))
        .toList(),
    userComment: r.userComment,
    status: RequestStatus.values.byName(r.status),
    aiCondition: r.aiCondition == null
        ? null
        : TreeCondition.values.byName(r.aiCondition!),
    aiConfidence: r.aiConfidence,
    createdByUserId: r.createdByUserId,
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
    syncAttempts: r.syncAttempts,
    lastError: r.lastError,
  );

  WorkRequestsTableCompanion _toCompanion(WorkRequest r) =>
      WorkRequestsTableCompanion.insert(
        id: r.id,
        treeLocalId: drift.Value(r.treeLocalId),
        localPhotoPath: r.localPhotoPath,
        remotePhotoUrl: drift.Value(r.remotePhotoUrl),
        latitude: r.latitude,
        longitude: r.longitude,
        userProblemsCsv: r.userProblems.map((e) => e.name).join(','),
        userComment: drift.Value(r.userComment),
        status: r.status.name,
        aiCondition: drift.Value(r.aiCondition?.name),
        aiConfidence: drift.Value(r.aiConfidence),
        createdByUserId: drift.Value(r.createdByUserId),
        createdAt: r.createdAt,
        updatedAt: r.updatedAt,
        syncAttempts: drift.Value(r.syncAttempts),
        lastError: drift.Value(r.lastError),
      );
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}