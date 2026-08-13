import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/work_request.dart';

class MyRequestsScreen extends ConsumerWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(myRequestsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои заявки'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Принудительно обновляем данные
              ref.invalidate(myRequestsProvider);
            },
          ),
        ],
      ),
      body: requestsAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.inbox, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'У вас пока нет заявок',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Сфотографируйте дерево, чтобы начать',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final request = list[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  leading: _buildStatusIcon(request.status),
                  title: Text(
                    request.userProblems.map((e) => _problemLabel(e)).join(', '),
                    style: const TextStyle(fontWeight: FontWeight.w500),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Статус: ${_statusLabel(request.status)}',
                        style: TextStyle(
                          color: _statusColor(request.status),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        '${request.createdAt.day}.${request.createdAt.month}.${request.createdAt.year} ${request.createdAt.hour.toString().padLeft(2, '0')}:${request.createdAt.minute.toString().padLeft(2, '0')}',
                        style: const TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // Переход на экран деталей
                    context.push('/history/request/${request.id}');
                  },
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.red),
              const SizedBox(height: 16),
              Text('Ошибка: $err'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(myRequestsProvider),
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusIcon(RequestStatus status) {
    IconData iconData;
    Color color;
    switch (status) {
      case RequestStatus.draftLocal:
        iconData = Icons.save;
        color = Colors.grey;
        break;
      case RequestStatus.pendingUpload:
        iconData = Icons.cloud_upload;
        color = Colors.orange;
        break;
      case RequestStatus.pendingAI:
        iconData = Icons.psychology;
        color = Colors.blue;
        break;
      case RequestStatus.approved:
        iconData = Icons.check_circle;
        color = Colors.green;
        break;
      case RequestStatus.needsModeration:
        iconData = Icons.hourglass_empty;
        color = Colors.orange;
        break;
      case RequestStatus.rejected:
        iconData = Icons.cancel;
        color = Colors.red;
        break;
      case RequestStatus.failed:
        iconData = Icons.error;
        color = Colors.red;
        break;
    }
    return Icon(iconData, color: color, size: 30);
  }

  String _statusLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.draftLocal:
        return 'Сохранено локально';
      case RequestStatus.pendingUpload:
        return 'Загрузка фото...';
      case RequestStatus.pendingAI:
        return 'Анализ AI...';
      case RequestStatus.approved:
        return 'Одобрено';
      case RequestStatus.needsModeration:
        return 'На модерации';
      case RequestStatus.rejected:
        return 'Отклонено';
      case RequestStatus.failed:
        return 'Ошибка';
    }
  }

  Color _statusColor(RequestStatus status) {
    switch (status) {
      case RequestStatus.draftLocal:
        return Colors.grey;
      case RequestStatus.pendingUpload:
        return Colors.orange;
      case RequestStatus.pendingAI:
        return Colors.blue;
      case RequestStatus.approved:
        return Colors.green;
      case RequestStatus.needsModeration:
        return Colors.orange;
      case RequestStatus.rejected:
        return Colors.red;
      case RequestStatus.failed:
        return Colors.red;
    }
  }

  String _problemLabel(ProblemType type) {
    switch (type) {
      case ProblemType.dry:
        return 'Сухое';
      case ProblemType.damagedTrunk:
        return 'Повреждён ствол';
      case ProblemType.brokenBranches:
        return 'Сломанные ветви';
      case ProblemType.leaning:
        return 'Наклон';
      case ProblemType.diseased:
        return 'Болезни';
      case ProblemType.other:
        return 'Другое';
    }
  }
}