import 'package:drift/drift.dart' as drift;

import '../../domain/enums/domain_enums.dart';
import '../../domain/models/inspection.dart';
import '../../domain/models/tree.dart';
import '../../domain/repositories/repositories.dart';
import '../local/database.dart';
import '../local/tables/trees_table.dart';
import '../local/tables/inspections_table.dart';
import '../remote/firebase/firestore_service.dart';

/// Источник правды для UI — локальный Drift-кэш (мгновенно, офлайн).
/// Firestore используется как удалённый бэкенд: слушаем его и зеркалируем
/// изменения в Drift, а также пишем в него при подтверждении/создании.
class TreeRepositoryImpl implements TreeRepository {
  TreeRepositoryImpl(this._db, this._firestore) {
    // Держим локальный кэш синхронным с Firestore, пока есть сеть.
    _firestore.watchTrees().listen((trees) async {
      for (final t in trees) {
        await _db.treeDao.upsertTree(_toCompanion(t));
      }
    });
  }

  final AppDatabase _db;
  final FirestoreService _firestore;

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
    await _firestore.upsertTree(tree); // no-op/queued by SDK if offline
  }

  @override
  Future<void> addInspection(Inspection inspection) async {
    await _db.treeDao.addInspection(InspectionsTableCompanion.insert(
      id: inspection.id,
      treeLocalId: inspection.treeLocalId,
      photoUrl: inspection.photoUrl,
      aiCondition: inspection.aiCondition.name,
      aiConfidence: drift.Value(inspection.aiConfidence),
      inspectedAt: inspection.inspectedAt,
      inspectorId: drift.Value(inspection.inspectorId),
    ));
    await _firestore.addInspection(inspection);
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

  TreesTableCompanion _toCompanion(Tree t) => TreesTableCompanion.insert(
    localId: t.localId,
    remoteId: drift.Value(t.id),
    latitude: t.latitude,
    longitude: t.longitude,
    category: t.category.name,
    condition: t.condition.name,
    status: t.status.name,
    mainPhotoUrl: drift.Value(t.mainPhotoUrl),
    lastInspectionDate: t.lastInspectionDate,
    recommendation: drift.Value(t.recommendation),
    priority: t.priority.name,
    createdAt: t.createdAt,
    updatedAt: t.updatedAt,
  );
}