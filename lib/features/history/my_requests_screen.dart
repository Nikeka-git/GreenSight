import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/providers.dart';
import '../../domain/models/work_request.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/specimen_tag.dart';
import '../../core/widgets/status_style.dart';
import '../../core/widgets/tree_mark.dart';

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
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () => ref.invalidate(myRequestsProvider),
          ),
        ],
      ),
      body: requestsAsync.when(
        data: (list) {
          if (list.isEmpty) return const _EmptyState();
          return RefreshIndicator(
            color: AppColors.canopy,
            onRefresh: () async => ref.invalidate(myRequestsProvider),
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
              itemCount: list.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) => _RequestCard(request: list[index]),
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator(color: AppColors.canopy)),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 56, color: AppColors.rust),
              const SizedBox(height: 16),
              Text('Ошибка: $err', textAlign: TextAlign.center),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () => ref.invalidate(myRequestsProvider),
                child: const Text('Повторить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TreeMark(size: 72, color: AppColors.inkFaint, strokeWidth: 2.2),
            const SizedBox(height: 20),
            Text('Заявок пока нет', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(
              'Сфотографируйте дерево на вкладке «Камера» —\nоно появится здесь',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});
  final WorkRequest request;

  @override
  Widget build(BuildContext context) {
    final style = StatusStyle.of(request.status);
    final problems = request.userProblems.map(problemLabel).join(', ');
    final date = request.createdAt;
    final dateStr =
        '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

    return Material(
      color: AppColors.birchCard,
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadii.md),
        onTap: () => context.push('/history/request/${request.id}'),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(AppRadii.sm),
                child: request.localPhotoPath.isNotEmpty
                    ? Image.file(
                        File(request.localPhotoPath),
                        width: 64,
                        height: 64,
                        fit: BoxFit.cover,
                      )
                    : Container(
                        width: 64,
                        height: 64,
                        color: AppColors.divider,
                        child: const Icon(Icons.park_outlined,
                            color: AppColors.inkFaint),
                      ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      problems.isEmpty ? 'Без описания' : problems,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 15),
                    ),
                    const SizedBox(height: 8),
                    SpecimenTag(
                      label: style.label,
                      icon: style.icon,
                      foreground: style.fg,
                      background: style.bg,
                      dense: true,
                    ),
                    const SizedBox(height: 8),
                    Text(dateStr, style: AppTypography.mono(size: 11)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.inkFaint),
            ],
          ),
        ),
      ),
    );
  }
}
