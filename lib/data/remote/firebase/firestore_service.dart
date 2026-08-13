import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/models/tree.dart';
import '../../../domain/models/inspection.dart';
import '../../../domain/models/work_request.dart';

/// Тонкая обёртка над Firestore. Коллекции:
///   trees/{localId}            — паспорта деревьев (localId = docId, чтобы
///                                  избежать двойной записи id<->localId)
///   trees/{localId}/inspections/{id} — история осмотров
///   work_requests/{id}         — заявки (зеркало локальной Drift-таблицы)
///
/// Правила безопасности Firestore должны разрешать:
///   - citizen/inspector: create work_requests (только свои), read trees;
///   - admin: read/write всё.
class FirestoreService {
  FirestoreService(this._db);
  final FirebaseFirestore _db;

  CollectionReference<Map<String, dynamic>> get _trees =>
      _db.collection('trees');
  CollectionReference<Map<String, dynamic>> get _requests =>
      _db.collection('work_requests');

  Stream<List<Tree>> watchTrees() {
    return _trees.snapshots().map(
          (s) => s.docs.map((d) => Tree.fromMap({...d.data(), 'id': d.id})).toList(),
    );
  }

  Future<void> upsertTree(Tree tree) =>
      _trees.doc(tree.localId).set(tree.toMap(), SetOptions(merge: true));

  Future<void> addInspection(Inspection inspection) => _trees
      .doc(inspection.treeLocalId)
      .collection('inspections')
      .doc(inspection.id)
      .set(inspection.toMap());

  Future<void> upsertWorkRequest(WorkRequest request) =>
      _requests.doc(request.id).set({
        'treeLocalId': request.treeLocalId,
        'remotePhotoUrl': request.remotePhotoUrl,
        'latitude': request.latitude,
        'longitude': request.longitude,
        'userProblems': request.userProblems.map((e) => e.name).toList(),
        'userComment': request.userComment,
        'status': request.status.name,
        'aiCondition': request.aiCondition?.name,
        'aiConfidence': request.aiConfidence,
        'createdByUserId': request.createdByUserId,
        'createdAt': request.createdAt.toIso8601String(),
        'updatedAt': request.updatedAt.toIso8601String(),
      }, SetOptions(merge: true));

  Stream<List<Map<String, dynamic>>> watchModerationQueue() {
    return _requests
        .where('status', isEqualTo: 'needsModeration')
        .snapshots()
        .map((s) => s.docs.map((d) => {...d.data(), 'id': d.id}).toList());
  }
}