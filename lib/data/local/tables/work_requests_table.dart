import 'package:drift/drift.dart';

@DataClassName('WorkRequestsTableData')
class WorkRequestsTable extends Table {
  TextColumn get id => text()();
  TextColumn get treeLocalId => text().nullable()();

  TextColumn get localPhotoPath => text()();
  TextColumn get remotePhotoUrl => text().nullable()();

  RealColumn get latitude => real()();
  RealColumn get longitude => real()();

  TextColumn get userProblemsCsv => text()();
  TextColumn get userComment => text().nullable()();

  TextColumn get status => text()();

  TextColumn get aiCondition => text().nullable()();
  RealColumn get aiConfidence => real().nullable()();

  TextColumn get createdByUserId => text()();

  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  IntColumn get syncAttempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}