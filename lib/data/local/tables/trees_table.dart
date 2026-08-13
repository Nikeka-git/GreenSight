import 'package:drift/drift.dart';

@DataClassName('TreesTableData')
class TreesTable extends Table {
  TextColumn get localId => text()();
  TextColumn get remoteId => text().nullable()();

  RealColumn get latitude => real()();   // было DoubleColumn
  RealColumn get longitude => real()();

  TextColumn get category => text()();
  TextColumn get condition => text()();
  TextColumn get status => text()();

  TextColumn get mainPhotoUrl => text().nullable()();
  DateTimeColumn get lastInspectionDate => dateTime()();

  TextColumn get recommendation => text().nullable()();
  TextColumn get priority => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {localId};
}