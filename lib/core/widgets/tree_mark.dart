import 'package:flutter/material.dart';

/// Простая рисованная линией марка дерева — используется вместо иконки
/// из Material-набора там, где нужен "фирменный" брендинг (сплэш, пустые
/// состояния). Рисуется CustomPaint, так что не требует внешних SVG.
/// Три яруса кроны + ствол — силуэт, близкий к берёзе/тополю на бирках парка.
class TreeMark extends StatelessWidget {
  const TreeMark({
    super.key,
    this.size = 64,
    this.color = const Color(0xFF1F3D2B),
    this.strokeWidth = 2.4,
  });

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _TreeMarkPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}

class _TreeMarkPainter extends CustomPainter {
  _TreeMarkPainter({required this.color, required this.strokeWidth});
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final w = size.width;
    final h = size.height;
    final cx = w / 2;

    // Ствол
    canvas.drawLine(Offset(cx, h * 0.98), Offset(cx, h * 0.62), paint);

    // Три яруса кроны — сужаются кверху, как у хвойных на схематичных
    // ботанических значках.
    final tiers = [
      _Tier(topY: h * 0.02, bottomY: h * 0.34, halfWidth: w * 0.18),
      _Tier(topY: h * 0.22, bottomY: h * 0.52, halfWidth: w * 0.28),
      _Tier(topY: h * 0.40, bottomY: h * 0.66, halfWidth: w * 0.38),
    ];

    for (final t in tiers) {
      final path = Path()
        ..moveTo(cx, t.topY)
        ..lineTo(cx - t.halfWidth, t.bottomY)
        ..lineTo(cx + t.halfWidth, t.bottomY)
        ..close();
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _TreeMarkPainter oldDelegate) =>
      oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
}

class _Tier {
  const _Tier({required this.topY, required this.bottomY, required this.halfWidth});
  final double topY;
  final double bottomY;
  final double halfWidth;
}
