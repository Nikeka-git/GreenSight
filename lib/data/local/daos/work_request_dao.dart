import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/work_requests_table.dart';

part 'work_request_dao.g.dart';

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

  /// Заявки, ожидающие отправки: черновики, ожидающие загрузки или
  /// упавшие с ошибкой (для повторной попытки в SyncService).
  Future<List<WorkRequestsTableData>> getPendingSyncBatch({int limit = 10}) {
    return (select(workRequestsTable)
      ..where((t) => t.status.isIn([
        'draftLocal',
        'pendingUpload',
        'failed',
      ]))
      ..orderBy([(t) => OrderingTerm.asc(t.createdAt)])
      ..limit(limit))
        .get();
  }

  Future<void> insertOrUpdate(WorkRequestsTableCompanion row) =>
      into(workRequestsTable).insertOnConflictUpdate(row);
}