import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/work_requests_table.dart';

part 'work_request_dao.g.dart';

/// Maximum automatic push attempts before a request stays `failed` until the
/// user retries manually.
const int maxSyncRetries = 5;

@DriftAccessor(tables: [WorkRequestsTable])
class WorkRequestDao extends DatabaseAccessor<AppDatabase>
    with _$WorkRequestDaoMixin {
  WorkRequestDao(super.db);

  Stream<List<WorkRequestsTableData>> watchAll() =>
      (select(workRequestsTable)
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<WorkRequestsTableData>> watchByUser(String userId) =>
      (select(workRequestsTable)
        ..where((t) => t.createdByUserId.equals(userId))
        ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
          .watch();

  Stream<List<WorkRequestsTableData>> watchByStatus(String status) =>
      (select(workRequestsTable)..where((t) => t.status.equals(status)))
          .watch();

  Future<WorkRequestsTableData?> getById(String id) =>
      (select(workRequestsTable)..where((t) => t.id.equals(id)))
          .getSingleOrNull();

  /// Rows still waiting to be pushed to the server: drafts, uploads and
  /// failed (below the retry cap). `pendingAI` rows are already on the server
  /// and are only reconciled via pull.
  Future<List<WorkRequestsTableData>> getPendingSyncBatch({int limit = 10}) {
    return (select(workRequestsTable)
      ..where((t) =>
          t.status.isIn(['draftLocal', 'pendingUpload', 'failed']) &
          t.syncAttempts.isSmallerThanValue(maxSyncRetries))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
      ..limit(limit))
        .get();
  }

  Future<void> insertOrUpdate(WorkRequestsTableCompanion row) async {
    await into(workRequestsTable).insert(
      row,
      onConflict: DoUpdate(
            (old) => row,
        target: [workRequestsTable.id],
      ),
    );
  }
}