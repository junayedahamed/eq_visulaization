import 'package:flutter/material.dart';

/// [MathFunction] represents a mathematical function of two variables (x, y).
/// It returns a double value which can be used for implicit equation plotting.
typedef MathFunction = double Function(double x, double y);

/// [AnimationType] defines how the mathematical equation is revealed during the animation process.
enum AnimationType {
  /// The curve is revealed starting from the origin (0,0) and moving outwards.
  radial,

  /// The curve is revealed point-by-point following its path, creating a "hand-drawn" effect.
  sequential,

  /// The curve is revealed from the leftmost visible point to the rightmost.
  linearX,

  /// The curve is revealed from the topmost visible point to the bottom.
  linearY,
}

/// [EquationType] defines whether the equation is in Cartesian or Polar coordinates.
enum EquationType { cartesian, polar }

/// [InequalityType] defines if the equation is an equality or a specific inequality.
enum InequalityType {
  /// The standard f(x, y) = 0 equality.
  none,

  /// f(x, y) >= 0 (area filled where f(x, y) >= 0)
  greaterThanOrEqual,

  /// f(x, y) <= 0 (area filled where f(x, y) <= 0)
  lessThanOrEqual,
}

/// [EquationConfig] holds the configuration for a single mathematical equation in the plot.
/// It includes the [function] itself, visual properties like [color] and [strokeWidth],
/// and optional constraints like [minX], [maxX], etc.
class EquationConfig {
  /// The actual [MathFunction] to be plotted.
  final MathFunction function;

  /// Whether the function is in Cartesian (x, y) or Polar (r, theta) coordinates.
  final EquationType type;

  /// The type of inequality to visualize.
  final InequalityType inequality;

  /// The color used to draw this specific equation's curve/region.
  final Color color;

  /// The opacity of the filled region for inequalities (0.0 to 1.0).
  final double fillOpacity;

  /// The thickness of the curve line.
  final double strokeWidth;

  /// Optional override for the [AnimationType]. If null, the [EquationPainter.animationType] is used.
  final AnimationType? animationType;

  /// Optional minimum X value (mathematical coordinates) to bound the plotting.
  final double? minX;

  /// Optional maximum X value (mathematical coordinates) to bound the plotting.
  final double? maxX;

  /// Optional minimum Y value (mathematical coordinates) to bound the plotting.
  final double? minY;

  /// Optional maximum Y value (mathematical coordinates) to bound the plotting.
  final double? maxY;

  const EquationConfig({
    required this.function,
    this.type = EquationType.cartesian,
    this.inequality = InequalityType.none,
    this.color = Colors.blue,
    this.fillOpacity = 0.3,
    this.strokeWidth = 2.0,
    this.animationType,
    this.minX,
    this.maxX,
    this.minY,
    this.maxY,
  });
}
