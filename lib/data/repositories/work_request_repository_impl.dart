import 'package:drift/drift.dart' as drift;
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/work_request.dart';
import '../../domain/repositories/repositories.dart';
import '../local/database.dart';

/// Реализация репозитория заявок, работающая только с локальной БД (Drift).
/// Все операции выполняются мгновенно и без удалённых вызовов.
class WorkRequestRepositoryImpl implements WorkRequestRepository {
  WorkRequestRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<WorkRequest>> watchAll() =>
      _db.workRequestDao.watchAll().map((r) => r.map(_fromRow).toList());

  @override
  Stream<List<WorkRequest>> watchByUser(String userId) => _db.workRequestDao
      .watchByUser(userId)
      .map((r) => r.map(_fromRow).toList());


  @override
  Future<WorkRequest?> getById(String id) async {
    final row = await _db.workRequestDao.getById(id);
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<List<WorkRequest>> getPendingSyncBatch({int limit = 10}) async {
    final rows = await _db.workRequestDao.getPendingSyncBatch(limit: limit);
    return rows.map(_fromRow).toList();
  }

  @override
  Future<void> createLocal(WorkRequest request) async {
    await _db.workRequestDao.insertOrUpdate(_toCompanion(request));
  }

  @override
  Future<void> update(WorkRequest request) async {
    await _db.workRequestDao.insertOrUpdate(_toCompanion(request));
  }

  WorkRequest _fromRow(WorkRequestsTableData r) => WorkRequest(
    id: r.id,
    treeLocalId: r.treeLocalId,
    localPhotoPath: r.localPhotoPath,
    remotePhotoId: r.remotePhotoId,
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
      WorkRequestsTableCompanion(
        id: drift.Value(r.id),
        treeLocalId: drift.Value(r.treeLocalId),
        localPhotoPath: drift.Value(r.localPhotoPath),
        remotePhotoId: drift.Value(r.remotePhotoId),
        remotePhotoUrl: drift.Value(r.remotePhotoUrl),
        latitude: drift.Value(r.latitude),
        longitude: drift.Value(r.longitude),
        userProblemsCsv: drift.Value(r.userProblems.map((e) => e.name).join(',')),
        userComment: drift.Value(r.userComment),
        status: drift.Value(r.status.name),
        aiCondition: drift.Value(r.aiCondition?.name),
        aiConfidence: drift.Value(r.aiConfidence),
        createdByUserId: drift.Value(r.createdByUserId),
        createdAt: drift.Value(r.createdAt),
        updatedAt: drift.Value(r.updatedAt),
        syncAttempts: drift.Value(r.syncAttempts),
        lastError: drift.Value(r.lastError),
      );
}
