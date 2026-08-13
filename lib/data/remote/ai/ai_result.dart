import '../../../domain/enums/domain_enums.dart';

/// Ответ AI-сервера на анализ фото дерева.
/// ВАЖНО: модель сейчас ещё обучается — эндпоинт и точный формат ответа
/// нужно будет сверить с бэкенд/ML-командой. Здесь заложен ожидаемый
/// контракт, чтобы фронтенд мог разрабатываться параллельно.
class AiResult {
  final TreeCondition condition;
  final double confidence; // 0..1
  final bool matchesUserReport; // подтвердил ли AI то, что указал юзер
  final String? recommendation;
  final WorkPriority suggestedPriority;

  const AiResult({
    required this.condition,
    required this.confidence,
    required this.matchesUserReport,
    this.recommendation,
    required this.suggestedPriority,
  });

  factory AiResult.fromJson(Map<String, dynamic> json) => AiResult(
    condition: TreeCondition.values.byName(json['condition'] as String),
    confidence: (json['confidence'] as num).toDouble(),
    matchesUserReport: json['matches_user_report'] as bool,
    recommendation: json['recommendation'] as String?,
    suggestedPriority:
    WorkPriority.values.byName(json['priority'] as String? ?? 'low'),
  );
}