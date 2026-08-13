// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_request_dao.dart';

// ignore_for_file: type=lint
mixin _$WorkRequestDaoMixin on DatabaseAccessor<AppDatabase> {
  $WorkRequestsTableTable get workRequestsTable =>
      attachedDatabase.workRequestsTable;
  WorkRequestDaoManager get managers => WorkRequestDaoManager(this);
}

class WorkRequestDaoManager {
  final _$WorkRequestDaoMixin _db;
  WorkRequestDaoManager(this._db);
  $$WorkRequestsTableTableTableManager get workRequestsTable =>
      $$WorkRequestsTableTableTableManager(
        _db.attachedDatabase,
        _db.workRequestsTable,
      );
}
