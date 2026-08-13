import 'dart:io';

import 'package:chopper/chopper.dart';

import '../../../domain/enums/domain_enums.dart';
import 'ai_result.dart';

/// Клиент к вашему серверу с обученной моделью компьютерного зрения.
/// Модель сейчас в процессе обучения, поэтому:
///  1) baseUrl — заглушка, замените на реальный эндпоинт когда он появится;
///  2) analyzePhoto() параллельно поддерживает "mock"-режим (см. флаг ниже),
///     чтобы UI и SyncService можно было тестировать уже сейчас.
class AiApiClient {
  AiApiClient._(this._chopper);

  final ChopperClient _chopper;

  /// Пока модель не готова — включите mock-ответы, чтобы не блокировать
  /// разработку остальной части приложения.
  static const bool useMock = true;

  factory AiApiClient.create({
    String baseUrl = 'https://ai.greensight.example.kz/api/v1',
  }) {
    final chopper = ChopperClient(
      baseUrl: Uri.parse(baseUrl),
      services: [],
    );
    return AiApiClient._(chopper);
  }

  Future<AiResult> analyzePhoto({
    required File photo,
    required double latitude,
    required double longitude,
    required List<String> userProblemCodes,
  }) async {
    if (useMock) {
      return _mockAnalyze(userProblemCodes);
    }

    final request = Request(
      'POST',
      Uri.parse('/analyze'),
      _chopper.baseUrl,
      multipartFile: [PartValueFile('photo', photo.path)],
      parts: [
        PartValue('latitude', latitude.toString()),
        PartValue('longitude', longitude.toString()),
        PartValue('user_problems', userProblemCodes.join(',')),
      ],
      multipart: true,
    );

    final response = await _chopper.send<Map<String, dynamic>, dynamic>(
      request,
    );

    if (!response.isSuccessful || response.body == null) {
      throw AiApiException(
        'AI server error: ${response.statusCode} ${response.error}',
      );
    }

    return AiResult.fromJson(response.body!);
  }

  /// Временная заглушка, пока обучается реальная модель.
  /// Логика: с вероятностью ~70% "соглашается" с пользователем — этого
  /// достаточно, чтобы прогнать оба сценария (approved / needsModeration)
  /// через SyncService и экран модерации.
  Future<AiResult> _mockAnalyze(List<String> userProblemCodes) async {
    await Future.delayed(const Duration(seconds: 2));
    final agrees = DateTime.now().millisecond % 10 < 7;
    final condition = agrees && userProblemCodes.isNotEmpty
        ? _conditionFromProblemCode(userProblemCodes.first)
        : TreeCondition.healthy;
    return AiResult(
      condition: condition,
      confidence: agrees ? 0.86 : 0.52,
      matchesUserReport: agrees,
      recommendation: agrees
          ? 'Рекомендуется плановая обрезка в течение 30 дней'
          : null,
      suggestedPriority: agrees ? WorkPriority.high : WorkPriority.low,
    );
  }

  TreeCondition _conditionFromProblemCode(String code) {
    return TreeCondition.values
        .where((c) => c.name == code)
        .firstOrNull ?? TreeCondition.diseased;
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}

class AiApiException implements Exception {
  AiApiException(this.message);
  final String message;
  @override
  String toString() => message;
}