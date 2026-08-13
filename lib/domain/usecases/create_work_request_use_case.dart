import 'dart:io';
import 'package:uuid/uuid.dart';
import '../enums/domain_enums.dart';
import '../models/work_request.dart';
import '../repositories/repositories.dart';
import '../../core/services/sync_service.dart';

class CreateWorkRequestUseCase {
  CreateWorkRequestUseCase({
    required this.workRequestRepo,
    required this.syncService,
  });
  final WorkRequestRepository workRequestRepo;
  final SyncService syncService;

  Future<void> execute({
    required File photo,
    required double latitude,
    required double longitude,
    required List<ProblemType> problems,
    required String userComment,
    required String userId,
  }) async {
    final id = const Uuid().v4();
    final request = WorkRequest(
      id: id,
      localPhotoPath: photo.path,
      latitude: latitude,
      longitude: longitude,
      userProblems: problems,
      userComment: userComment,
      status: RequestStatus.draftLocal,
      createdByUserId: userId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await workRequestRepo.createLocal(request);
    // Запускаем синхронизацию сразу
    syncService.syncNow();
  }
}