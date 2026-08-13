import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';   // <-- было riverpod

import '../core/network/connectivity_service.dart';
import '../core/services/sync_service.dart';               // путь исправлен
import '../data/local/database.dart';
import '../data/remote/ai/ai_api_client.dart';
import '../data/remote/firebase/firestore_service.dart';
import '../data/remote/firebase/photo_storage_service.dart';
import '../data/repositories/tree_repository_impl.dart';
import '../data/repositories/work_request_repository_impl.dart';
import '../domain/repositories/repositories.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  return ConnectivityService();
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(FirebaseFirestore.instance);
});

final photoStorageServiceProvider = Provider<PhotoStorageService>((ref) {
  return PhotoStorageService(FirebaseStorage.instance);
});

final aiApiClientProvider = Provider<AiApiClient>((ref) {
  return AiApiClient.create(
    baseUrl: 'https://ai.greensight.example.kz/api/v1',
  );
});

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final treeRepositoryProvider = Provider<TreeRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final firestore = ref.watch(firestoreServiceProvider);
  return TreeRepositoryImpl(db, firestore);
});

final workRequestRepositoryProvider = Provider<WorkRequestRepository>((ref) {
  final db = ref.watch(databaseProvider);
  final firestore = ref.watch(firestoreServiceProvider);
  return WorkRequestRepositoryImpl(db, firestore);
});

final syncServiceProvider = Provider<SyncService>((ref) {
  final service = SyncService(
    connectivity: ref.watch(connectivityServiceProvider),
    workRequestRepo: ref.watch(workRequestRepositoryProvider),
    treeRepo: ref.watch(treeRepositoryProvider),
    aiClient: ref.watch(aiApiClientProvider),
    photoStorage: ref.watch(photoStorageServiceProvider),
    firestore: ref.watch(firestoreServiceProvider),
    auth: ref.watch(firebaseAuthProvider),
  );
  service.start();
  ref.onDispose(service.dispose);
  return service;
});