import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/models/work_request.dart';
import '../../providers/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/specimen_tag.dart';
import '../../core/widgets/status_style.dart';
import '../../core/widgets/decor.dart';

class RequestDetailScreen extends ConsumerWidget {
  final String requestId;

  const RequestDetailScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allRequests = ref.watch(myRequestsProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Карточка заявки')),
      body: allRequests.when(
        data: (requests) {
          final request = requests.where((r) => r.id == requestId).firstOrNull;
          if (request == null) {
            return const Center(child: Text('Заявка не найдена'));
          }
          return _Content(request: request);
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.canopy)),
        error: (err, stack) => Center(child: Text('Ошибка: $err')),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({required this.request});
  final WorkRequest request;

  @override
  Widget build(BuildContext context) {
    final style = StatusStyle.of(request.status);
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (request.localPhotoPath.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadii.md),
              child: Image.file(
                File(request.localPhotoPath),
                height: 220,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          const SizedBox(height: 16),
          SpecimenTag(
            label: style.label,
            icon: style.icon,
            foreground: style.fg,
            background: style.bg,
          ),
          const SizedBox(height: 24),

          const SectionLabel('Проблемы'),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: request.userProblems
                .map((p) => Chip(
                      label: Text(problemLabel(p)),
                      avatar: Icon(problemIcon(p), size: 16),
                      backgroundColor: AppColors.birchCard,
                      side: const BorderSide(color: AppColors.divider),
                      labelStyle: AppTypography.textTheme.bodyMedium
                          ?.copyWith(color: AppColors.ink),
                    ))
                .toList(),
          ),

          if (request.userComment != null && request.userComment!.isNotEmpty) ...[
            const SizedBox(height: 24),
            const SectionLabel('Комментарий'),
            const SizedBox(height: 10),
            Text(request.userComment!, style: Theme.of(context).textTheme.bodyLarge),
          ],

          const SizedBox(height: 24),
          const SectionLabel('Полевые данные'),
          const SizedBox(height: 10),
          _DataCard(
            rows: [
              _DataRow('Координаты',
                  '${request.latitude.toStringAsFixed(5)}, ${request.longitude.toStringAsFixed(5)}'),
              _DataRow('Создано', _formatDate(request.createdAt)),
              if (request.aiCondition != null)
                _DataRow(
                  'AI-анализ',
                  '${request.aiCondition!.name} '
                      '(${request.aiConfidence != null ? (request.aiConfidence! * 100).toStringAsFixed(0) : '?'}%)',
                ),
            ],
          ),

          if (request.status == RequestStatus.failed) ...[
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // TODO: повторная попытка синхронизации через syncServiceProvider
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Повторить отправку'),
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.rust),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    final l = d.toLocal();
    return '${l.day.toString().padLeft(2, '0')}.${l.month.toString().padLeft(2, '0')}.${l.year}'
        ' · ${l.hour.toString().padLeft(2, '0')}:${l.minute.toString().padLeft(2, '0')}';
  }
}

class _DataRow {
  const _DataRow(this.label, this.value);
  final String label;
  final String value;
}

class _DataCard extends StatelessWidget {
  const _DataCard({required this.rows});
  final List<_DataRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.birchCard,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: AppColors.divider),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Column(
        children: [
          for (int i = 0; i < rows.length; i++) ...[
            if (i > 0) const Divider(height: 1, color: AppColors.divider),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(rows[i].label, style: Theme.of(context).textTheme.bodyMedium),
                  Text(rows[i].value, style: AppTypography.mono(size: 12.5, color: AppColors.ink)),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}
