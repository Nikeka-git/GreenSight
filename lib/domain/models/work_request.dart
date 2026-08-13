import '../enums/domain_enums.dart';

/// Заявка пользователя на осмотр/работы
class WorkRequest {
  final String id;
  final String? treeLocalId;
  final String localPhotoPath;
  final String? remotePhotoId;
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
    this.remotePhotoId,
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
    String? remotePhotoId,
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
      remotePhotoId: remotePhotoId ?? this.remotePhotoId,
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

  /// Payload sent to POST /api/work-requests. Status is always `pendingAI`:
  /// the server owns AI analysis and the final verdict.
  Map<String, dynamic> toApiPayload() => {
        'id': id,
        'treeLocalId': treeLocalId,
        'remotePhotoId': remotePhotoId,
        'latitude': latitude,
        'longitude': longitude,
        'userProblems': userProblems.map((p) => p.name).toList(),
        'userComment': userComment,
        'status': 'pendingAI',
        'createdByUserId': createdByUserId,
        'createdAt': createdAt.toUtc().toIso8601String(),
      };

  /// Reconstruct a request from the backend response. The backend never sends
  /// a local photo path, so the caller passes the local one (empty when the
  /// request originated on another device).
  factory WorkRequest.fromApiJson(
    Map<String, dynamic> json, {
    String localPhotoPath = '',
  }) {
    final aiCondition = json['aiCondition'] as String?;
    return WorkRequest(
      id: json['id'] as String,
      treeLocalId: json['treeLocalId'] as String?,
      localPhotoPath: localPhotoPath,
      remotePhotoId: json['remotePhotoId'] as String?,
      remotePhotoUrl: json['remotePhotoUrl'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      userProblems: ((json['userProblems'] as List?) ?? const [])
          .map((e) => ProblemType.values.byName(e as String))
          .toList(),
      userComment: json['userComment'] as String?,
      status: RequestStatus.values.byName(json['status'] as String),
      aiCondition: aiCondition == null
          ? null
          : TreeCondition.values.byName(aiCondition),
      aiConfidence: (json['aiConfidence'] as num?)?.toDouble(),
      createdByUserId: (json['createdByUserId'] as String?) ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] as String? ?? '') ?? DateTime.now(),
      syncAttempts: (json['syncAttempts'] as num?)?.toInt() ?? 0,
      lastError: json['lastError'] as String?,
    );
  }
}
