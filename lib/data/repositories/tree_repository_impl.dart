import 'package:drift/drift.dart' as drift;
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/tree.dart';
import '../../domain/models/inspection.dart';
import '../../domain/repositories/repositories.dart';
import '../local/database.dart';
import '../local/tables/trees_table.dart';

/// Реализация репозитория деревьев, работающая только с локальной БД (Drift).
/// Все операции выполняются синхронно и без удалённых вызовов.
class TreeRepositoryImpl implements TreeRepository {
  TreeRepositoryImpl(this._db);

  final AppDatabase _db;

  @override
  Stream<List<Tree>> watchAllTrees() {
    return _db.treeDao.watchAllTrees().map(
          (rows) => rows.map(_fromRow).toList(),
    );
  }

  @override
  Future<Tree?> getByLocalId(String localId) async {
    final row = await _db.treeDao.getByLocalId(localId);
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<Tree?> findNearbyDuplicate(
      double latitude,
      double longitude, {
        double radiusMeters = 5,
      }) async {
    final row = await _db.treeDao.findNearby(latitude, longitude, radiusMeters);
    return row == null ? null : _fromRow(row);
  }

  @override
  Future<void> upsertTree(Tree tree) async {
    await _db.treeDao.upsertTree(_toCompanion(tree));
  }

  @override
  Future<void> addInspection(Inspection inspection) async {
    await _db.treeDao.addInspection(InspectionsTableCompanion(
      id: drift.Value(inspection.id),
      treeLocalId: drift.Value(inspection.treeLocalId),
      photoUrl: drift.Value(inspection.photoUrl),
      aiCondition: drift.Value(inspection.aiCondition.name),
      aiConfidence: drift.Value(inspection.aiConfidence),
      inspectedAt: drift.Value(inspection.inspectedAt),
      inspectorId: drift.Value(inspection.inspectorId),
    ));
  }

  @override
  Stream<List<Inspection>> watchInspections(String treeLocalId) {
    return _db.treeDao.watchInspections(treeLocalId).map(
          (rows) => rows
          .map((r) => Inspection(
        id: r.id,
        treeLocalId: r.treeLocalId,
        photoUrl: r.photoUrl,
        aiCondition: TreeCondition.values.byName(r.aiCondition),
        aiConfidence: r.aiConfidence,
        inspectedAt: r.inspectedAt,
        inspectorId: r.inspectorId,
      ))
          .toList(),
    );
  }

  Tree _fromRow(TreesTableData r) => Tree(
    id: r.remoteId,
    localId: r.localId,
    latitude: r.latitude,
    longitude: r.longitude,
    category: TreeCategory.values.byName(r.category),
    condition: TreeCondition.values.byName(r.condition),
    status: TreeStatus.values.byName(r.status),
    mainPhotoUrl: r.mainPhotoUrl,
    lastInspectionDate: r.lastInspectionDate,
    recommendation: r.recommendation,
    priority: WorkPriority.values.byName(r.priority),
    createdAt: r.createdAt,
    updatedAt: r.updatedAt,
  );

  TreesTableCompanion _toCompanion(Tree t) => TreesTableCompanion(
    localId: drift.Value(t.localId),
    remoteId: drift.Value(t.id),
    latitude: drift.Value(t.latitude),
    longitude: drift.Value(t.longitude),
    category: drift.Value(t.category.name),
    condition: drift.Value(t.condition.name),
    status: drift.Value(t.status.name),
    mainPhotoUrl: drift.Value(t.mainPhotoUrl),
    lastInspectionDate: drift.Value(t.lastInspectionDate),
    recommendation: drift.Value(t.recommendation),
    priority: drift.Value(t.priority.name),
    createdAt: drift.Value(t.createdAt),
    updatedAt: drift.Value(t.updatedAt),
  );
}