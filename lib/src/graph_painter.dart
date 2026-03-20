import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'equation_config.dart';

class GraphPainter extends CustomPainter {
  final List<Float32List> allPoints;
  final List<EquationConfig> equations;
  final double animationProgress;

  GraphPainter({
    required this.allPoints,
    required this.equations,
    required this.animationProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (allPoints.isEmpty) return;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < allPoints.length; i++) {
      if (i >= equations.length) break;
      final points = allPoints[i];
      final config = equations[i];

      if (config.inequality != InequalityType.none) {
        paint.color = config.color.withValues(
          alpha: config.fillOpacity * animationProgress,
        );
        paint.style = PaintingStyle.fill;
        canvas.drawRawPoints(ui.PointMode.points, points, paint);
        // Using points for simplicity with drawRawPoints if they are many.
        // Actually for rectangles/triangles we should use drawVertices or drawRawPoints of type polygons
        // But drawRawPoints(points, ...) treats it as individual points.
        // Let's use it as triangles
        canvas.drawRawPoints(ui.PointMode.lines, points, paint);
        // Actually let's use a simple path or drawRect for each sampled point if it's too many
        // For performance let's stick to points or a special draw call.
        continue;
      }

      paint.color = config.color;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = config.strokeWidth;

      final totalSegments = points.length ~/ 4;
      final countToDraw = (totalSegments * animationProgress).toInt();
      if (countToDraw <= 0) continue;

      final pointsToDraw = Float32List.sublistView(points, 0, countToDraw * 4);
      canvas.drawRawPoints(ui.PointMode.lines, pointsToDraw, paint);
    }
  }

  @override
  bool shouldRepaint(covariant GraphPainter oldDelegate) {
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.allPoints != allPoints ||
        oldDelegate.equations != equations;
  }
}
