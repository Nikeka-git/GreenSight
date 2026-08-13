import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/providers.dart';
import '../../domain/enums/domain_enums.dart';

class MyRequestsScreen extends ConsumerWidget {
  const MyRequestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final requestsAsync = ref.watch(myRequestsProvider); // это AsyncValue

    return Scaffold(
      appBar: AppBar(title: const Text('Мои заявки')),
      body: requestsAsync.when(
        data: (list) {
          if (list.isEmpty) {
            return const Center(child: Text('Нет заявок'));
          }
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final r = list[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: ListTile(
                  title: Text(_statusLabel(r.status)),
                  subtitle: Text(r.userProblems.map((e) => e.name).join(', ')),
                  trailing: Text('${r.createdAt.day}.${r.createdAt.month}.${r.createdAt.year}'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }

  String _statusLabel(RequestStatus status) {
    switch (status) {
      case RequestStatus.draftLocal: return '💾 Сохранено локально';
      case RequestStatus.pendingUpload: return '⏳ Загрузка фото...';
      case RequestStatus.pendingAI: return '🤖 Анализ AI...';
      case RequestStatus.approved: return '✅ Одобрено';
      case RequestStatus.needsModeration: return '⏳ На модерации';
      case RequestStatus.rejected: return '❌ Отклонено';
      case RequestStatus.failed: return '⚠️ Ошибка';
    }
  }
}