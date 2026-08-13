import 'dart:math' as math;

import 'package:drift/drift.dart';

import '../database.dart';
import '../tables/trees_table.dart';
import '../tables/inspections_table.dart';

part 'tree_dao.g.dart';

@DriftAccessor(tables: [TreesTable, InspectionsTable])
class TreeDao extends DatabaseAccessor<AppDatabase> with _$TreeDaoMixin {
  TreeDao(super.db);

  Stream<List<TreesTableData>> watchAllTrees() => select(treesTable).watch();

  Future<TreesTableData?> getByLocalId(String localId) =>
      (select(treesTable)..where((t) => t.localId.equals(localId)))
          .getSingleOrNull();

  /// Простой bounding-box поиск ближайшего дерева. Для продакшена лучше
  /// заменить на geohash-индекс в Firestore, но для локального SQLite
  /// этого достаточно — таблица деревьев в масштабах одного города невелика.
  Future<TreesTableData?> findNearby(
      double lat,
      double lng,
      double radiusMeters,
      ) async {
    // ~1 градус широты ≈ 111_000 м
    final degDelta = radiusMeters / 111000;
    final candidates = await (select(treesTable)
      ..where((t) =>
      t.latitude.isBetweenValues(lat - degDelta, lat + degDelta) &
      t.longitude.isBetweenValues(lng - degDelta, lng + degDelta)))
        .get();
    if (candidates.isEmpty) return null;
    candidates.sort((a, b) {
      final da = _distanceMeters(lat, lng, a.latitude, a.longitude);
      final db_ = _distanceMeters(lat, lng, b.latitude, b.longitude);
      return da.compareTo(db_);
    });
    final closest = candidates.first;
    final dist =
    _distanceMeters(lat, lng, closest.latitude, closest.longitude);
    return dist <= radiusMeters ? closest : null;
  }

  Future<void> upsertTree(TreesTableCompanion tree) =>
      into(treesTable).insertOnConflictUpdate(tree);

  Future<void> addInspection(InspectionsTableCompanion inspection) =>
      into(inspectionsTable).insertOnConflictUpdate(inspection);

  Stream<List<InspectionsTableData>> watchInspections(String treeLocalId) =>
      (select(inspectionsTable)
        ..where((i) => i.treeLocalId.equals(treeLocalId))
        ..orderBy([(i) => OrderingTerm.desc(i.inspectedAt)]))
          .watch();
}

double _distanceMeters(double lat1, double lng1, double lat2, double lng2) {
  const r = 6371000.0; // метров
  final dLat = _deg2rad(lat2 - lat1);
  final dLng = _deg2rad(lng2 - lng1);
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(_deg2rad(lat1)) *
          math.cos(_deg2rad(lat2)) *
          math.sin(dLng / 2) *
          math.sin(dLng / 2);
  final c = 2 * math.asin(math.sqrt(a));
  return r * c;
}

double _deg2rad(double deg) => deg * (math.pi / 180);