import 'dart:math' as math;
import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/inspections_table.dart';
import '../tables/trees_table.dart';

part 'tree_dao.g.dart';

@DriftAccessor(tables: [TreesTable, InspectionsTable])
class TreeDao extends DatabaseAccessor<AppDatabase> with _$TreeDaoMixin {
  TreeDao(super.db);

  Stream<List<TreesTableData>> watchAllTrees() => select(treesTable).watch();

  Future<TreesTableData?> getByLocalId(String localId) =>
      (select(treesTable)..where((t) => t.localId.equals(localId)))
          .getSingleOrNull();

  Future<TreesTableData?> findNearby(
      double lat,
      double lng,
      double radiusMeters,
      ) async {
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
    final dist = _distanceMeters(lat, lng, closest.latitude, closest.longitude);
    return dist <= radiusMeters ? closest : null;
  }

  Future<void> upsertTree(TreesTableCompanion tree) async {
    await into(treesTable).insert(
      tree,
      onConflict: DoUpdate(
            (old) => tree,
        target: [treesTable.localId],
      ),
    );
  }

  Future<void> addInspection(InspectionsTableCompanion inspection) async {
    await into(inspectionsTable).insert(
      inspection,
      onConflict: DoUpdate(
            (old) => inspection,
        target: [inspectionsTable.id],
      ),
    );
  }

  Stream<List<InspectionsTableData>> watchInspections(String treeLocalId) =>
      (select(inspectionsTable)
        ..where((i) => i.treeLocalId.equals(treeLocalId))
        ..orderBy([(i) => OrderingTerm.desc(i.inspectedAt)]))
          .watch();
}

double _distanceMeters(double lat1, double lng1, double lat2, double lng2) {
  const r = 6371000.0;
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