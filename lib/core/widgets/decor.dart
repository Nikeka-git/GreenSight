import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Маленький "eyebrow"-лейбл над секцией — моноширинный, капслок,
/// с коротким тире вместо номера (нумерация 01/02/03 тут не нужна: это
/// не последовательный процесс, а просто заголовки независимых блоков).
class SectionLabel extends StatelessWidget {
  const SectionLabel(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(width: 14, height: 2, color: AppColors.amber),
        const SizedBox(width: 8),
        Text(text.toUpperCase(), style: AppTypography.textTheme.labelSmall),
      ],
    );
  }
}

/// Уголки видоискателя поверх превью камеры — вместо стандартной рамки
/// намекает на кадрирование образца для гербария/фотофиксации.
class ViewfinderCorners extends StatelessWidget {
  const ViewfinderCorners({
    super.key,
    this.color = Colors.white,
    this.inset = 28,
    this.padding,
    this.armLength = 26,
    this.strokeWidth = 2.6,
  });

  final Color color;
  final double inset;
  final EdgeInsets? padding;
  final double armLength;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Padding(
        padding: padding ?? EdgeInsets.all(inset),
        child: CustomPaint(
          painter: _CornerPainter(
            color: color,
            armLength: armLength,
            strokeWidth: strokeWidth,
          ),
          child: Container(),
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  _CornerPainter({
    required this.color,
    required this.armLength,
    required this.strokeWidth,
  });
  final Color color;
  final double armLength;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    void corner(Offset origin, bool right, bool bottom) {
      final dx = right ? -armLength : armLength;
      final dy = bottom ? -armLength : armLength;
      canvas.drawLine(origin, origin.translate(dx, 0), paint);
      canvas.drawLine(origin, origin.translate(0, dy), paint);
    }

    corner(const Offset(0, 0), false, false);
    corner(Offset(size.width, 0), true, false);
    corner(Offset(0, size.height), false, true);
    corner(Offset(size.width, size.height), true, true);
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) => false;
}
