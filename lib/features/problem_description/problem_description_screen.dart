import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/usecases/create_work_request_use_case.dart';
import '../../providers/providers.dart';
import '../../core/theme/app_theme.dart';
import '../../core/widgets/decor.dart';
import '../../core/widgets/status_style.dart';

class ProblemDescriptionScreen extends ConsumerStatefulWidget {
  final File photoFile;
  final double latitude;
  final double longitude;

  const ProblemDescriptionScreen({
    super.key,
    required this.photoFile,
    required this.latitude,
    required this.longitude,
  });

  @override
  ConsumerState<ProblemDescriptionScreen> createState() =>
      _ProblemDescriptionScreenState();
}

class _ProblemDescriptionScreenState
    extends ConsumerState<ProblemDescriptionScreen> {
  final Map<ProblemType, bool> _selectedProblems = {
    for (final p in ProblemType.values) p: false,
  };
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final selected = _selectedProblems.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selected.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Выберите хотя бы одну проблему')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final userId = await ref.read(localUserServiceProvider).getUserId();

      final useCase = CreateWorkRequestUseCase(
        workRequestRepo: ref.read(workRequestRepositoryProvider),
        syncService: ref.read(syncServiceProvider),
      );

      await useCase.execute(
        photo: widget.photoFile,
        latitude: widget.latitude,
        longitude: widget.longitude,
        problems: selected,
        userComment: _commentController.text.trim(),
        userId: userId,
      );

      ref.read(syncServiceProvider).syncNow();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заявка сохранена и отправлена в обработку'),
            backgroundColor: AppColors.canopy,
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: AppColors.rust),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Описание проблемы',
          style: AppTypography.strictTextTheme.headlineSmall,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PhotoTag(photoFile: widget.photoFile),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.place_outlined,
                            size: 14, color: AppColors.inkFaint),
                        const SizedBox(width: 4),
                        Text(
                          '${widget.latitude.toStringAsFixed(5)}, '
                          '${widget.longitude.toStringAsFixed(5)}',
                          style: AppTypography.mono(size: 11),
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    const SectionLabel('Что не так с деревом?'),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _selectedProblems.keys.map((type) {
                        final selected = _selectedProblems[type]!;
                        return _ProblemChip(
                          label: problemLabel(type),
                          icon: problemIcon(type),
                          selected: selected,
                          onTap: () => setState(
                            () => _selectedProblems[type] = !selected,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 28),
                    const SectionLabel('Комментарий (необязательно)'),
                    const SizedBox(height: 12),
                    TextField(
                      controller: _commentController,
                      maxLines: 4,
                      style: AppTypography.strictTextTheme.bodyLarge,
                      decoration: const InputDecoration(
                        hintText:
                            'Например: ветка нависает над детской площадкой…',
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              decoration: BoxDecoration(
                color: AppColors.birch,
                border: Border(top: BorderSide(color: AppColors.divider)),
              ),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _submit,
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.4,
                            color: AppColors.birch,
                          ),
                        )
                      : Text(
                          'Отправить заявку',
                          style: AppTypography.strictTextTheme.labelLarge
                              ?.copyWith(color: AppColors.birch),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PhotoTag extends StatelessWidget {
  const _PhotoTag({required this.photoFile});
  final File photoFile;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.md),
      child: Stack(
        children: [
          Image.file(
            photoFile,
            height: 210,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            left: 12,
            top: 12,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Text(
                'НОВЫЙ СНИМОК',
                style: AppTypography.mono(size: 10, color: Colors.white, weight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProblemChip extends StatelessWidget {
  const _ProblemChip({
    required this.label,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? AppColors.canopy : AppColors.birchCard,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(
            color: selected ? AppColors.canopy : AppColors.divider,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: selected ? AppColors.birch : AppColors.inkMuted),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTypography.strictTextTheme.bodyMedium?.copyWith(
                color: selected ? AppColors.birch : AppColors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
