import '../models/inspection.dart';
import '../models/tree.dart';
import '../models/work_request.dart';

abstract class TreeRepository {
  Stream<List<Tree>> watchAllTrees();
  Future<Tree?> getByLocalId(String localId);
  Future<Tree?> findNearbyDuplicate(double latitude, double longitude, {double radiusMeters});
  Future<void> upsertTree(Tree tree);
  Future<void> addInspection(Inspection inspection);
  Stream<List<Inspection>> watchInspections(String treeLocalId);
}

abstract class WorkRequestRepository {
  Stream<List<WorkRequest>> watchAll();
  Stream<List<WorkRequest>> watchByUser(String userId);
  Future<WorkRequest?> getById(String id);
  Future<List<WorkRequest>> getPendingSyncBatch({int limit});
  Future<void> createLocal(WorkRequest request);
  Future<void> update(WorkRequest request);
}