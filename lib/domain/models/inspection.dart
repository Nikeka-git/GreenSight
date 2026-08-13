import 'package:drift/drift.dart';

/// История осмотров дерева — одна запись на каждый прогон AI, независимо
/// от того, подтвердил AI проблему или нет.
class InspectionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get treeLocalId => text()();
  TextColumn get photoUrl => text()();
  TextColumn get aiCondition => text()();
  RealColumn get aiConfidence => real().nullable()();
  DateTimeColumn get inspectedAt => dateTime()();
  TextColumn get inspectorId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}