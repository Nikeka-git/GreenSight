import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Фирменный элемент дизайна: "бирка образца" — как настоящие
/// пронумерованные жестяные бирки на деревьях в парках. Использована
/// последовательно для статусов заявок, категорий и мелких лейблов —
/// это единственный "яркий" приём в интерфейсе, всё остальное спокойное.
///
/// Форма: скруглённый прямоугольник с "пробитым" отверстием слева и
/// тонкой перемычкой — рисуется CustomPaint, без внешних SVG/картинок.
class SpecimenTag extends StatelessWidget {
  const SpecimenTag({
    super.key,
    required this.label,
    required this.foreground,
    required this.background,
    this.icon,
    this.dense = false,
  });

  final String label;
  final Color foreground;
  final Color background;
  final IconData? icon;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final vPad = dense ? 5.0 : 7.0;
    return CustomPaint(
      painter: _TagPainter(background: background, foreground: foreground),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18, vPad, 12, vPad),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: dense ? 13 : 15, color: foreground),
              const SizedBox(width: 5),
            ],
            Text(
              label,
              style: AppTypography.mono(
                size: dense ? 11 : 12,
                color: foreground,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TagPainter extends CustomPainter {
  _TagPainter({required this.background, required this.foreground});
  final Color background;
  final Color foreground;

  @override
  void paint(Canvas canvas, Size size) {
    final r = size.height / 2;
    final rrect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(r),
    );
    final paint = Paint()..color = background;
    canvas.drawRRect(rrect, paint);

    // "пробитое" отверстие бирки
    final holeCenter = Offset(r * 0.85, size.height / 2);
    final holeRadius = size.height * 0.12;
    canvas.drawCircle(
      holeCenter,
      holeRadius,
      Paint()..color = foreground.withValues(alpha: 0.55),
    );
    canvas.drawCircle(
      holeCenter,
      holeRadius * 0.55,
      Paint()..color = background,
    );
  }

  @override
  bool shouldRepaint(covariant _TagPainter oldDelegate) =>
      oldDelegate.background != background ||
      oldDelegate.foreground != foreground;
}
