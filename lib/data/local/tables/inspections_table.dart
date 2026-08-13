import 'package:drift/drift.dart';

@DataClassName('InspectionsTableData')
class InspectionsTable extends Table {
  TextColumn get id => text()();
  TextColumn get treeLocalId => text()();

  TextColumn get photoUrl => text()();
  TextColumn get aiCondition => text()();
  RealColumn get aiConfidence => real()();

  DateTimeColumn get inspectedAt => dateTime()();
  TextColumn get inspectorId => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}