import '../models/tree.dart';
import '../models/work_request.dart';
import '../models/inspection.dart';

/// Абстракция над деревьями. Реализация в data/repositories умеет
/// объединять локальный кэш (Drift) и Firestore.
abstract class TreeRepository {
  Stream<List<Tree>> watchAllTrees();
  Future<Tree?> getByLocalId(String localId);

  /// Ищет дерево в радиусе [radiusMeters] от точки — используется, чтобы
  /// не плодить дубликаты паспортов при подтверждении AI (см. README,
  /// "Конфликты: у одного дерева не должно быть несколько паспортов").
  Future<Tree?> findNearbyDuplicate(
      double latitude,
      double longitude, {
        double radiusMeters = 5,
      });

  Future<void> upsertTree(Tree tree);
  Future<void> addInspection(Inspection inspection);
  Stream<List<Inspection>> watchInspections(String treeLocalId);
}

abstract class WorkRequestRepository {
  Stream<List<WorkRequest>> watchAll();
  Stream<List<WorkRequest>> watchByUser(String userId);
  Stream<List<WorkRequest>> watchPendingModeration();
  Future<List<WorkRequest>> getPendingSyncBatch({int limit = 10});

  Future<void> createLocal(WorkRequest request);
  Future<void> update(WorkRequest request);
  Future<void> markModerationDecision({
    required String requestId,
    required bool approved,
  });
}