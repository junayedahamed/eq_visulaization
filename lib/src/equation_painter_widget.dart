import 'package:flutter/material.dart';

typedef MathFunction = double Function(double x, double y);

/// Defines how the equation is revealed during animation.
enum AnimationType {
  /// Revealed from the center outwards.
  radial,

  /// Revealed point-by-point following the curve's path (hand-drawn effect).
  sequential,

  /// Revealed from left to right.
  linearX,

  /// Revealed from top to bottom.
  linearY,
}

/// Configuration for a single mathematical equation in the plot.
class EquationConfig {
  final MathFunction function;
  final Color color;
  final double strokeWidth;

  /// Optional override for the animation type. If null, the widget's default is used.
  final AnimationType? animationType;

  const EquationConfig({
    required this.function,
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
    this.animationType,
  });
}

/// A widget that draws multiple mathematical functions on a coordinate system with animation.
class EquationPainterWidget extends StatefulWidget {
  final List<EquationConfig> equations;
  final double width;
  final double height;
  final bool showGrid;
  final bool showAxis;
  final Color gridColor;
  final double gridStrokeWidth;
  final bool animate;
  final Duration animationDuration;

  /// The style of animation used to reveal the graph.
  final AnimationType animationType;

  /// Where the origin (0,0) is located on the canvas.
  /// Defaults to [Alignment.center].
  final Alignment alignment;

  const EquationPainterWidget({
    super.key,
    required this.equations,
    this.width = 300,
    this.height = 300,
    this.showGrid = true,
    this.showAxis = true,
    this.gridColor = const Color(0xFFE0E0E0),
    this.gridStrokeWidth = 1.0,
    this.animate = true,
    this.animationDuration = const Duration(milliseconds: 1500),
    this.animationType = AnimationType.radial,
    this.alignment = Alignment.center,
  });

  @override
  State<EquationPainterWidget> createState() => _EquationPainterWidgetState();
}

class _EquationPainterWidgetState extends State<EquationPainterWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List<List<_LineSegment>>? _allSegments;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    if (widget.animate) {
      _controller.forward();
    } else {
      _controller.value = 1.0;
    }
    _calculateAllSegments();
  }

  @override
  void didUpdateWidget(EquationPainterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if any significant property changed
    bool needsRecalc =
        oldWidget.width != widget.width ||
        oldWidget.height != widget.height ||
        oldWidget.animationType != widget.animationType ||
        oldWidget.alignment != widget.alignment ||
        oldWidget.equations.length != widget.equations.length;

    if (!needsRecalc) {
      for (int i = 0; i < widget.equations.length; i++) {
        if (oldWidget.equations[i].function != widget.equations[i].function ||
            oldWidget.equations[i].color != widget.equations[i].color ||
            oldWidget.equations[i].strokeWidth !=
                widget.equations[i].strokeWidth ||
            oldWidget.equations[i].animationType !=
                widget.equations[i].animationType) {
          needsRecalc = true;
          break;
        }
      }
    }

    if (needsRecalc) {
      _calculateAllSegments();
      if (widget.animate) {
        _controller.reset();
        _controller.forward();
      }
    }
  }

  void _calculateAllSegments() {
    final all = <List<_LineSegment>>[];
    for (final eq in widget.equations) {
      all.add(_calculateSegmentsFor(eq));
    }
    _allSegments = all;
  }

  List<_LineSegment> _calculateSegmentsFor(EquationConfig config) {
    final w = widget.width;
    final h = widget.height;
    const steps = 2.0;

    // Optimize: only scan the mathematical range that is actually visible
    // based on the chosen alignment.
    final minX = -(1 + widget.alignment.x) * w / 2;
    final maxX = minX + w;
    final minY = (1 + widget.alignment.y) * h / 2 - h;
    final maxY = minY + h;

    final rawSegments = <_LineSegment>[];

    for (double y = maxY; y >= minY; y -= steps) {
      for (double x = minX; x <= maxX; x += steps) {
        final tl = Offset(x, y);
        final tr = Offset(x + steps, y);
        final bl = Offset(x, y - steps);
        final br = Offset(x + steps, y - steps);

        final tlVal = config.function(tl.dx, tl.dy);
        final trVal = config.function(tr.dx, tr.dy);
        final blVal = config.function(bl.dx, bl.dy);
        final brVal = config.function(br.dx, br.dy);

        final points = <Offset>[];

        void check(Offset p1, double v1, Offset p2, double v2) {
          if ((v1 >= 0 && v2 <= 0) || (v1 <= 0 && v2 >= 0)) {
            if (v1 == v2) return;
            final t = v1 / (v1 - v2);
            points.add(
              Offset(p1.dx + t * (p2.dx - p1.dx), p1.dy + t * (p2.dy - p1.dy)),
            );
          }
        }

        check(tl, tlVal, tr, trVal);
        check(tr, trVal, br, brVal);
        check(br, brVal, bl, blVal);
        check(bl, blVal, tl, tlVal);

        if (points.length >= 2) {
          double dist = 0;
          final animType = config.animationType ?? widget.animationType;
          switch (animType) {
            case AnimationType.radial:
              dist =
                  ((points[0].dx + points[1].dx) / 2).abs() +
                  ((points[0].dy + points[1].dy) / 2).abs();
              break;
            case AnimationType.linearX:
              dist = (points[0].dx + points[1].dx) / 2;
              break;
            case AnimationType.linearY:
              dist = -((points[0].dy + points[1].dy) / 2);
              break;
            case AnimationType.sequential:
              dist = 0;
              break;
          }
          rawSegments.add(_LineSegment(points[0], points[1], dist));
        }
      }
    }

    if (rawSegments.isEmpty) return [];

    final animType = config.animationType ?? widget.animationType;
    if (animType == AnimationType.sequential) {
      return _sortSegmentsSequentially(rawSegments);
    } else {
      rawSegments.sort((a, b) => a.distance.compareTo(b.distance));
      return rawSegments;
    }
  }

  List<_LineSegment> _sortSegmentsSequentially(List<_LineSegment> segments) {
    final sorted = <_LineSegment>[];
    final unvisited = List<_LineSegment>.from(segments);

    while (unvisited.isNotEmpty) {
      var current = unvisited.removeAt(0);
      sorted.add(current);

      bool foundNext = true;
      while (foundNext && unvisited.isNotEmpty) {
        foundNext = false;
        Offset lastPoint = current.p2;

        int bestIdx = -1;
        bool reversed = false;
        double minFoundDist = 4.0; // Max search radius

        for (int i = 0; i < unvisited.length; i++) {
          final seg = unvisited[i];
          double d1 = (seg.p1 - lastPoint).distanceSquared;
          double d2 = (seg.p2 - lastPoint).distanceSquared;

          if (d1 < minFoundDist) {
            minFoundDist = d1;
            bestIdx = i;
            reversed = false;
          } else if (d2 < minFoundDist) {
            minFoundDist = d2;
            bestIdx = i;
            reversed = true;
          }
          if (minFoundDist < 0.01) break;
        }

        if (bestIdx != -1) {
          var nextSeg = unvisited.removeAt(bestIdx);
          if (reversed) {
            nextSeg = _LineSegment(nextSeg.p2, nextSeg.p1, 0);
          }
          sorted.add(nextSeg);
          current = nextSeg;
          foundNext = true;
        }
      }
    }
    return sorted;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // We use a Stack to separate the static background (Grid/Axis)
    // from the animated foreground (the Graph).
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: [
          // Static Background Layer
          if (widget.showGrid || widget.showAxis)
            RepaintBoundary(
              child: CustomPaint(
                size: Size(widget.width, widget.height),
                painter: _BackgroundPainter(
                  showGrid: widget.showGrid,
                  showAxis: widget.showAxis,
                  gridColor: widget.gridColor,
                  gridStrokeWidth: widget.gridStrokeWidth,
                  alignment: widget.alignment,
                ),
              ),
            ),

          // Animated Foreground Layer
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return CustomPaint(
                size: Size(widget.width, widget.height),
                painter: _GraphPainter(
                  allSegments: _allSegments ?? [],
                  equations: widget.equations,
                  animationProgress: _controller.value,
                  alignment: widget.alignment,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _LineSegment {
  final Offset p1;
  final Offset p2;
  final double distance;
  _LineSegment(this.p1, this.p2, this.distance);
}

/// Painter for static elements like Grid and Axis
class _BackgroundPainter extends CustomPainter {
  final bool showGrid;
  final bool showAxis;
  final Color gridColor;
  final double gridStrokeWidth;
  final Alignment alignment;

  _BackgroundPainter({
    required this.showGrid,
    required this.showAxis,
    required this.gridColor,
    required this.gridStrokeWidth,
    required this.alignment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final paint = Paint();

    // Origin position based on alignment
    final originX = (1 + alignment.x) * w / 2;
    final originY = (1 + alignment.y) * h / 2;

    // 1. Draw Grid relative to origin
    if (showGrid) {
      paint.color = gridColor;
      paint.strokeWidth = gridStrokeWidth;

      // Vertical lines spreading from origin
      for (double x = originX; x <= w; x += 40) {
        canvas.drawLine(Offset(x, 0), Offset(x, h), paint);
      }
      for (double x = originX - 40; x >= 0; x -= 40) {
        canvas.drawLine(Offset(x, 0), Offset(x, h), paint);
      }

      // Horizontal lines spreading from origin
      for (double y = originY; y <= h; y += 40) {
        canvas.drawLine(Offset(0, y), Offset(w, y), paint);
      }
      for (double y = originY - 40; y >= 0; y -= 40) {
        canvas.drawLine(Offset(0, y), Offset(w, y), paint);
      }
    }

    // 2. Draw Axis
    if (showAxis) {
      paint.color = Colors.black.withOpacity(0.5);
      paint.strokeWidth = 2.0;

      // X Axis
      if (originY >= 0 && originY <= h) {
        canvas.drawLine(Offset(0, originY), Offset(w, originY), paint);
      }
      // Y Axis
      if (originX >= 0 && originX <= w) {
        canvas.drawLine(Offset(originX, 0), Offset(originX, h), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _BackgroundPainter oldDelegate) {
    return oldDelegate.showGrid != showGrid ||
        oldDelegate.showAxis != showAxis ||
        oldDelegate.gridColor != gridColor ||
        oldDelegate.gridStrokeWidth != gridStrokeWidth ||
        oldDelegate.alignment != alignment;
  }
}

/// Painter for the animated graph segments
class _GraphPainter extends CustomPainter {
  final List<List<_LineSegment>> allSegments;
  final List<EquationConfig> equations;
  final double animationProgress;
  final Alignment alignment;

  _GraphPainter({
    required this.allSegments,
    required this.equations,
    required this.animationProgress,
    required this.alignment,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (allSegments.isEmpty) return;

    final w = size.width;
    final h = size.height;

    // Shifted origin mapping
    // c.dx is the mathematical x, c.dy is the mathematical y
    // (1 + alignment.x) * w / 2 gives the canvas x-coordinate of the mathematical origin (0,0)
    // (1 + alignment.y) * h / 2 gives the canvas y-coordinate of the mathematical origin (0,0)
    Offset f2m(Offset c) => Offset(
      (1 + alignment.x) * w / 2 + c.dx,
      (1 + alignment.y) * h / 2 -
          c.dy, // Invert y-axis for mathematical coordinates
    );

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round;

    for (int i = 0; i < allSegments.length; i++) {
      final segments = allSegments[i];
      final config = equations[i];
      paint.color = config.color;
      paint.strokeWidth = config.strokeWidth;

      final countToDraw = (segments.length * animationProgress).toInt();
      for (int j = 0; j < countToDraw; j++) {
        final segment = segments[j];
        canvas.drawLine(f2m(segment.p1), f2m(segment.p2), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GraphPainter oldDelegate) {
    // We need to check if the list of equations itself has changed,
    // or if any properties within the equations have changed.
    // For simplicity, we'll assume if allSegments changes, it implies equation changes.
    // A more robust check would iterate through equations list.
    return oldDelegate.animationProgress != animationProgress ||
        oldDelegate.allSegments !=
            allSegments || // This implies segments or their order changed
        oldDelegate.alignment != alignment ||
        oldDelegate.equations !=
            equations; // Check if the list of equations itself changed
  }
}
