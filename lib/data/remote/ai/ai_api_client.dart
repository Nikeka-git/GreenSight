import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../domain/enums/domain_enums.dart';
import 'ai_result.dart';   // теперь лежит в той же папке

class AiApiClient {
  AiApiClient({required this.baseUrl});
  final String baseUrl;

  static const bool useMock = true;

  factory AiApiClient.create({
    String baseUrl = 'https://ai.greensight.example.kz/api/v1',
  }) {
    return AiApiClient(baseUrl: baseUrl);
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

    final uri = Uri.parse('$baseUrl/analyze');
    final request = http.MultipartRequest('POST', uri)
      ..files.add(await http.MultipartFile.fromPath('photo', photo.path))
      ..fields['latitude'] = latitude.toString()
      ..fields['longitude'] = longitude.toString()
      ..fields['user_problems'] = userProblemCodes.join(',');

    final response = await request.send();
    if (response.statusCode != 200) {
      final errorBody = await response.stream.bytesToString();
      throw AiApiException('AI server error: ${response.statusCode} $errorBody');
    }

    final responseBody = await response.stream.bytesToString();
    final json = jsonDecode(responseBody) as Map<String, dynamic>;
    return AiResult.fromJson(json);
  }

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