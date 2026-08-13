import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

/// Загрузка фото деревьев в облачное хранилище.
///
/// В исходном плане фигурировали одновременно "s3 (скорее всего)" и
/// firebase — см. замечание в README о выборе одного хранилища. Здесь
/// реализовано через firebase_storage, потому что вы и так используете
/// Firestore: одна авторизация (firebase_auth), одни правила доступа,
/// не нужно поднимать отдельный S3-совместимый сервис и хранить его ключи
/// на устройстве. Если S3 обязателен по инфраструктурным причинам —
/// замените реализацию этого класса, остальной код от этого не зависит
/// (используется только через интерфейс upload()/getUrl()).
class PhotoStorageService {
  PhotoStorageService(this._storage);
  final FirebaseStorage _storage;

  Future<String> uploadTreePhoto({
    required File file,
    required String requestId,
  }) async {
    final ref = _storage.ref('tree_photos/$requestId.jpg');
    final task = await ref.putFile(
      file,
      SettableMetadata(contentType: 'image/jpeg'),
    );
    return task.ref.getDownloadURL();
  }
}