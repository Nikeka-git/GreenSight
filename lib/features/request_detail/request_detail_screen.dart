import 'dart:io'; // <-- добавляем для File
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/domain_enums.dart'; // <-- добавляем для RequestStatus
import '../../domain/models/work_request.dart';
import '../../providers/providers.dart';

class RequestDetailScreen extends ConsumerWidget {
  final String requestId;

  const RequestDetailScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allRequests = ref.watch(myRequestsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Детали заявки')),
      body: allRequests.when(
        data: (requests) {
          final request = requests.firstWhere(
                (r) => r.id == requestId,
            orElse: () => throw Exception('Заявка не найдена'),
          );
          return _buildContent(request);
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }

  Widget _buildContent(WorkRequest request) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Фото
          if (request.localPhotoPath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(request.localPhotoPath), // <-- теперь работает
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          // Статус
          Text('Статус: ${_statusLabel(request.status)}',
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          // Проблемы
          Text('Проблемы: ${request.userProblems.map((e) => e.name).join(', ')}'),
          const SizedBox(height: 8),
          // Комментарий
          if (request.userComment != null && request.userComment!.isNotEmpty)
            Text('Комментарий: ${request.userComment}'),
          const SizedBox(height: 8),
          // Координаты
          Text('Координаты: ${request.latitude}, ${request.longitude}'),
          const SizedBox(height: 8),
          // Дата
          Text('Создано: ${request.createdAt.toLocal()}'),
          if (request.aiCondition != null) ...[
            const SizedBox(height: 8),
            Text('AI: ${request.aiCondition!.name} (${request.aiConfidence?.toStringAsFixed(2) ?? '?'})'),
          ],
          // Дополнительно: если заявка в статусе failed, можно добавить кнопку повтора
          if (request.status == RequestStatus.failed)
            ElevatedButton(
              onPressed: () {
                // TODO: повторная попытка синхронизации
              },
              child: const Text('Повторить отправку'),
            ),
        ],
      ),
    );
  }

  String _statusLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.draftLocal:
        return '💾 Сохранено локально';
      case RequestStatus.pendingUpload:
        return '⏳ Загрузка фото...';
      case RequestStatus.pendingAI:
        return '🤖 Анализ AI...';
      case RequestStatus.approved:
        return '✅ Одобрено';
      case RequestStatus.needsModeration:
        return '⏳ На модерации';
      case RequestStatus.rejected:
        return '❌ Отклонено';
      case RequestStatus.failed:
        return '⚠️ Ошибка';
    }
  }
}