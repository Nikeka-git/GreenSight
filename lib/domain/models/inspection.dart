import '../enums/domain_enums.dart';

/// История осмотра дерева
class Inspection {
  final String id;
  final String treeLocalId;
  final String photoUrl;
  final TreeCondition aiCondition;
  final double aiConfidence;
  final DateTime inspectedAt;
  final String? inspectorId;

  Inspection({
    required this.id,
    required this.treeLocalId,
    required this.photoUrl,
    required this.aiCondition,
    required this.aiConfidence,
    required this.inspectedAt,
    this.inspectorId,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'treeLocalId': treeLocalId,
    'photoUrl': photoUrl,
    'aiCondition': aiCondition.name,
    'aiConfidence': aiConfidence,
    'inspectedAt': inspectedAt.toIso8601String(),
    'inspectorId': inspectorId,
  };

  factory Inspection.fromMap(Map<String, dynamic> map) => Inspection(
    id: map['id'] as String,
    treeLocalId: map['treeLocalId'] as String,
    photoUrl: map['photoUrl'] as String,
    aiCondition: TreeCondition.values.byName(map['aiCondition'] as String),
    aiConfidence: (map['aiConfidence'] as num).toDouble(),
    inspectedAt: DateTime.parse(map['inspectedAt'] as String),
    inspectorId: map['inspectorId'] as String?,
  );
}