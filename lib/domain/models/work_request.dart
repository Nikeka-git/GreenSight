import 'package:drift/drift.dart';

/// Главная таблица офлайн-очереди. Каждая заявка пользователя живёт тут
/// с момента фото до полной синхронизации с сервером/Firestore.
class WorkRequestsTable extends Table {
  TextColumn get id => text()(); // uuid, PK, стабилен с момента создания
  TextColumn get treeLocalId => text().nullable()();
  TextColumn get localPhotoPath => text()();
  TextColumn get remotePhotoUrl => text().nullable()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  // Список ProblemType.name, сериализован через запятую (см. WorkRequestDao)
  TextColumn get userProblemsCsv => text()();
  TextColumn get userComment => text().nullable()();
  TextColumn get status => text()(); // RequestStatus.name
  TextColumn get aiCondition => text().nullable()();
  RealColumn get aiConfidence => real().nullable()();
  TextColumn get createdByUserId => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get updatedAt => dateTime()();
  IntColumn get syncAttempts => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}