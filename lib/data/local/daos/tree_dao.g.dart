// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_dao.dart';

// ignore_for_file: type=lint
mixin _$TreeDaoMixin on DatabaseAccessor<AppDatabase> {
  $TreesTableTable get treesTable => attachedDatabase.treesTable;
  $InspectionsTableTable get inspectionsTable =>
      attachedDatabase.inspectionsTable;
  TreeDaoManager get managers => TreeDaoManager(this);
}

class TreeDaoManager {
  final _$TreeDaoMixin _db;
  TreeDaoManager(this._db);
  $$TreesTableTableTableManager get treesTable =>
      $$TreesTableTableTableManager(_db.attachedDatabase, _db.treesTable);
  $$InspectionsTableTableTableManager get inspectionsTable =>
      $$InspectionsTableTableTableManager(
        _db.attachedDatabase,
        _db.inspectionsTable,
      );
}
