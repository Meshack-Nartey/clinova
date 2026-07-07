import 'package:flutter/material.dart';

/// Clinova node-cross logo mark.
///
/// Draws a medical cross whose arms end in circular nodes with a larger hub
/// at the centre. All geometry is vector (CustomPainter), no assets required.
class ClinovaLogo extends StatelessWidget {
  const ClinovaLogo({
    super.key,
    this.size = 48,
    this.foreground = Colors.white,
    this.background,
  });

  final double size;
  final Color foreground;

  /// If non-null a rounded-square background is drawn behind the mark.
  final Color? background;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _LogoPainter(foreground: foreground, background: background),
    );
  }
}

class _LogoPainter extends CustomPainter {
  const _LogoPainter({required this.foreground, this.background});

  final Color foreground;
  final Color? background;

  @override
  void paint(Canvas canvas, Size size) {
    final s = size.width / 200;
    final fg = Paint()
      ..color = foreground
      ..isAntiAlias = true;

    if (background != null) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(48 * s),
        ),
        Paint()
          ..color = background!
          ..isAntiAlias = true,
      );
    }

    // Cross bars
    canvas.drawRect(Rect.fromLTWH(92 * s, 44 * s, 16 * s, 112 * s), fg);
    canvas.drawRect(Rect.fromLTWH(44 * s, 92 * s, 112 * s, 16 * s), fg);

    // Arm-end nodes
    for (final offset in [
      Offset(100 * s, 44 * s),
      Offset(100 * s, 156 * s),
      Offset(44 * s, 100 * s),
      Offset(156 * s, 100 * s),
    ]) {
      canvas.drawCircle(offset, 13 * s, fg);
    }

    // Centre hub
    canvas.drawCircle(Offset(100 * s, 100 * s), 21 * s, fg);
  }

  @override
  bool shouldRepaint(_LogoPainter old) =>
      old.foreground != foreground || old.background != background;
}
