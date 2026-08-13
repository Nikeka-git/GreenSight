import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/trees_table.dart';
import 'tables/work_requests_table.dart';
import 'tables/inspections_table.dart';
import 'daos/tree_dao.dart';
import 'daos/work_request_dao.dart';

part 'database.g.dart'; // сгенерируется через build_runner (см. README)

/// Единственная точка входа в локальную SQLite-базу (Drift).
/// Это ядро офлайн-first логики: всё, что делает пользователь без сети,
/// пишется сюда синхронно и немедленно.
@DriftDatabase(
  tables: [TreesTable, WorkRequestsTable, InspectionsTable],
  daos: [TreeDao, WorkRequestDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());
  AppDatabase.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    // При добавлении полей в таблицы — поднимайте schemaVersion и
    // добавляйте onUpgrade со стратегией миграции, не пересоздавайте БД,
    // иначе потеряете несинхронизированные офлайн-заявки пользователей.
  );
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'greensight.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}