import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/enums/domain_enums.dart';
import '../../domain/usecases/create_work_request_use_case.dart';
import '../../providers/providers.dart';

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

      // Запускаем синхронизацию
      ref.read(syncServiceProvider).syncNow();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Заявка сохранена и отправлена в обработку'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.popUntil(context, (route) => route.isFirst);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Ошибка: $e'),
            backgroundColor: Colors.red,
          ),
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
        title: const Text('Описание проблемы'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                widget.photoFile,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Выберите проблемы:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._selectedProblems.keys.map((type) {
                      return CheckboxListTile(
                        title: Text(_problemLabel(type)),
                        value: _selectedProblems[type],
                        onChanged: (value) {
                          setState(() {
                            _selectedProblems[type] = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        dense: true,
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    const Text(
                      'Комментарий (необязательно):',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: _commentController,
                      decoration: const InputDecoration(
                        hintText: 'Опишите проблему подробнее...',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _isSubmitting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: _isSubmitting
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                    : const Text(
                  'Отправить заявку',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  String _problemLabel(ProblemType type) {
    switch (type) {
      case ProblemType.dry:
        return 'Сухое дерево';
      case ProblemType.damagedTrunk:
        return 'Повреждён ствол';
      case ProblemType.brokenBranches:
        return 'Сломанные или опасно нависающие ветви';
      case ProblemType.leaning:
        return 'Наклоненное дерево';
      case ProblemType.diseased:
        return 'Признаки заболеваний или усыхания';
      case ProblemType.other:
        return 'Другое (укажите в комментарии)';
    }
  }
}