import 'package:flutter/material.dart';
import '../../domain/enums/domain_enums.dart';
import 'app_theme_exports.dart';

class StatusStyle {
  const StatusStyle(this.label, this.icon, this.fg, this.bg);
  final String label;
  final IconData icon;
  final Color fg;
  final Color bg;

  static StatusStyle of(RequestStatus status) {
    switch (status) {
      case RequestStatus.draftLocal:
        return StatusStyle(
          'СОХРАНЕНО ЛОКАЛЬНО',
          Icons.save_outlined,
          AppColors.inkMuted,
          AppColors.inkMuted.withValues(alpha: 0.12),
        );
      case RequestStatus.pendingUpload:
        return StatusStyle(
          'ЗАГРУЗКА ФОТО',
          Icons.cloud_upload_outlined,
          AppColors.amber,
          AppColors.amber.withValues(alpha: 0.14),
        );
      case RequestStatus.pendingAI:
        return StatusStyle(
          'AI АНАЛИЗИРУЕТ',
          Icons.psychology_outlined,
          AppColors.steppeBlue,
          AppColors.steppeBlue.withValues(alpha: 0.14),
        );
      case RequestStatus.approved:
        return StatusStyle(
          'ОДОБРЕНО',
          Icons.check_circle_outline,
          AppColors.canopy,
          AppColors.canopy.withValues(alpha: 0.12),
        );
      case RequestStatus.needsModeration:
        return StatusStyle(
          'НА МОДЕРАЦИИ',
          Icons.hourglass_empty,
          AppColors.amber,
          AppColors.amber.withValues(alpha: 0.14),
        );
      case RequestStatus.rejected:
        return StatusStyle(
          'ОТКЛОНЕНО',
          Icons.close_rounded,
          AppColors.rust,
          AppColors.rust.withValues(alpha: 0.12),
        );
      case RequestStatus.failed:
        return StatusStyle(
          'ОШИБКА ОТПРАВКИ',
          Icons.error_outline,
          AppColors.rust,
          AppColors.rust.withValues(alpha: 0.12),
        );
    }
  }
}

String problemLabel(ProblemType type) {
  switch (type) {
    case ProblemType.dry:
      return 'Сухое дерево';
    case ProblemType.damagedTrunk:
      return 'Повреждён ствол';
    case ProblemType.brokenBranches:
      return 'Сломанные ветви';
    case ProblemType.leaning:
      return 'Наклон';
    case ProblemType.diseased:
      return 'Признаки болезни';
    case ProblemType.other:
      return 'Другое';
  }
}

IconData problemIcon(ProblemType type) {
  switch (type) {
    case ProblemType.dry:
      return Icons.grass_outlined;
    case ProblemType.damagedTrunk:
      return Icons.broken_image_outlined;
    case ProblemType.brokenBranches:
      return Icons.content_cut;
    case ProblemType.leaning:
      return Icons.rotate_left;
    case ProblemType.diseased:
      return Icons.bug_report_outlined;
    case ProblemType.other:
      return Icons.more_horiz;
  }
}
