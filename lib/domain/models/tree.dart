import '../enums/domain_enums.dart';
import 'work_request.dart';

class Tree {
  final String? id;
  final String localId;
  final double latitude;
  final double longitude;
  final TreeCategory category;
  final TreeCondition condition;
  final TreeStatus status;
  final String? mainPhotoUrl;
  final DateTime lastInspectionDate;
  final String? recommendation;
  final WorkPriority priority;
  final DateTime createdAt;
  final DateTime updatedAt;

  Tree({
    this.id,
    required this.localId,
    required this.latitude,
    required this.longitude,
    required this.category,
    required this.condition,
    required this.status,
    this.mainPhotoUrl,
    required this.lastInspectionDate,
    this.recommendation,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
  });

  Tree copyWith({
    String? id,
    String? localId,
    double? latitude,
    double? longitude,
    TreeCategory? category,
    TreeCondition? condition,
    TreeStatus? status,
    String? mainPhotoUrl,
    DateTime? lastInspectionDate,
    String? recommendation,
    WorkPriority? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Tree(
      id: id ?? this.id,
      localId: localId ?? this.localId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      category: category ?? this.category,
      condition: condition ?? this.condition,
      status: status ?? this.status,
      mainPhotoUrl: mainPhotoUrl ?? this.mainPhotoUrl,
      lastInspectionDate: lastInspectionDate ?? this.lastInspectionDate,
      recommendation: recommendation ?? this.recommendation,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() => {
    'localId': localId,
    'latitude': latitude,
    'longitude': longitude,
    'category': category.name,
    'condition': condition.name,
    'status': status.name,
    'mainPhotoUrl': mainPhotoUrl,
    'lastInspectionDate': lastInspectionDate.toIso8601String(),
    'recommendation': recommendation,
    'priority': priority.name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };

  factory Tree.fromMap(Map<String, dynamic> map) => Tree(
    id: map['id'] as String?,
    localId: map['localId'] as String,
    latitude: (map['latitude'] as num).toDouble(),
    longitude: (map['longitude'] as num).toDouble(),
    category: TreeCategory.values.byName(map['category'] as String),
    condition: TreeCondition.values.byName(map['condition'] as String),
    status: TreeStatus.values.byName(map['status'] as String),
    mainPhotoUrl: map['mainPhotoUrl'] as String?,
    lastInspectionDate: DateTime.parse(map['lastInspectionDate'] as String),
    recommendation: map['recommendation'] as String?,
    priority: WorkPriority.values.byName(map['priority'] as String),
    createdAt: DateTime.parse(map['createdAt'] as String),
    updatedAt: DateTime.parse(map['updatedAt'] as String),
  );

  factory Tree.fromWorkRequest(WorkRequest request, TreeCondition condition) {
    final now = DateTime.now();
    return Tree(
      localId: request.treeLocalId ?? 'tree_${now.millisecondsSinceEpoch}',
      latitude: request.latitude,
      longitude: request.longitude,
      category: TreeCategory.unknown,
      condition: condition,
      status: condition == TreeCondition.healthy
          ? TreeStatus.healthy
          : TreeStatus.needsWork,
      lastInspectionDate: now,
      recommendation: null,
      priority: WorkPriority.medium,
      createdAt: now,
      updatedAt: now,
    );
  }
}