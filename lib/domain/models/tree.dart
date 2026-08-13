import 'package:drift/drift.dart';

/// Локальный кэш деревьев. Зеркалирует Firestore-коллекцию `trees`,
/// чтобы карта и паспорт открывались мгновенно и офлайн.
class TreesTable extends Table {
  TextColumn get localId => text()(); // uuid, PK
  TextColumn get remoteId => text().withDefault(const Constant(''))();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get category => text()(); // TreeCategory.name
  TextColumn get condition => text()(); // TreeCondition.name
  TextColumn get status => text()(); // TreeStatus.name
  TextColumn get mainPhotoUrl => text().nullable()();
  DateTimeColumn get lastInspectionDate => dateTime()();
  TextColumn get recommendation => text().nullable()();
  TextColumn get priority => text()(); // WorkPriority.name
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {localId};
}