import '../enums/domain_enums.dart';

/// Заявка пользователя на осмотр/работы
class WorkRequest {
  final String id;
  final String? treeLocalId;
  final String localPhotoPath;
  final String? remotePhotoUrl;
  final double latitude;
  final double longitude;
  final List<ProblemType> userProblems;
  final String? userComment;
  final RequestStatus status;
  final TreeCondition? aiCondition;
  final double? aiConfidence;
  final String createdByUserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int syncAttempts;
  final String? lastError;

  WorkRequest({
    required this.id,
    this.treeLocalId,
    required this.localPhotoPath,
    this.remotePhotoUrl,
    required this.latitude,
    required this.longitude,
    required this.userProblems,
    this.userComment,
    required this.status,
    this.aiCondition,
    this.aiConfidence,
    required this.createdByUserId,
    required this.createdAt,
    required this.updatedAt,
    this.syncAttempts = 0,
    this.lastError,
  });

  WorkRequest copyWith({
    String? id,
    String? treeLocalId,
    String? localPhotoPath,
    String? remotePhotoUrl,
    double? latitude,
    double? longitude,
    List<ProblemType>? userProblems,
    String? userComment,
    RequestStatus? status,
    TreeCondition? aiCondition,
    double? aiConfidence,
    String? createdByUserId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? syncAttempts,
    String? lastError,
  }) {
    return WorkRequest(
      id: id ?? this.id,
      treeLocalId: treeLocalId ?? this.treeLocalId,
      localPhotoPath: localPhotoPath ?? this.localPhotoPath,
      remotePhotoUrl: remotePhotoUrl ?? this.remotePhotoUrl,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      userProblems: userProblems ?? this.userProblems,
      userComment: userComment ?? this.userComment,
      status: status ?? this.status,
      aiCondition: aiCondition ?? this.aiCondition,
      aiConfidence: aiConfidence ?? this.aiConfidence,
      createdByUserId: createdByUserId ?? this.createdByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      syncAttempts: syncAttempts ?? this.syncAttempts,
      lastError: lastError ?? this.lastError,
    );
  }
}