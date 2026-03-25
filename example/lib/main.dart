import 'dart:math';

import 'package:equation_painter/equation_painter.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Equation Visualizer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        primaryColor: const Color(0xFF6366F1),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.dark,
        ),
      ),
      home: const EquationVisualizerPage(),
    );
  }
}

class EquationVisualizerPage extends StatefulWidget {
  const EquationVisualizerPage({super.key});

  @override
  State<EquationVisualizerPage> createState() => _EquationVisualizerPageState();
}

class _EquationVisualizerPageState extends State<EquationVisualizerPage> {
  int _exampleIndex = 0;

  final List<String> _titles = [
    'Cartesian Support & Tap',
    'Polar Coordinate Support',
    'Inequality Visualization',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_exampleIndex]),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(16.0),
      //       child: SegmentedButton<int>(
      //         segments: const [
      //           ButtonSegment(
      //             value: 0,
      //             label: Text('Cartesian'),
      //             icon: Icon(Icons.grid_4x4),
      //           ),
      //           ButtonSegment(
      //             value: 1,
      //             label: Text('Polar'),
      //             icon: Icon(Icons.bubble_chart),
      //           ),
      //           ButtonSegment(
      //             value: 2,
      //             label: Text('Inequality'),
      //             icon: Icon(Icons.format_color_fill),
      //           ),
      //         ],
      //         selected: {_exampleIndex},
      //         onSelectionChanged: (val) =>
      //             setState(() => _exampleIndex = val.first),
      //       ),
      //     ),
      //     Expanded(child: ClipRect(child: _buildExample())),
      //     const Padding(
      //       padding: EdgeInsets.all(16.0),
      //       child: Text(
      //         'Pinch to zoom, drag to pan. Tap curves to see coordinates.',
      //         style: TextStyle(color: Colors.white54, fontSize: 12),
      //       ),
      //     ),
      //   ],
      // ),
      body: EquationPainter(
        showAxisLabel: true,
        labelColor: Colors.white70,
        equations: [
          EquationConfig(
            function: EquationParser.parse("x^2 + y^2 - 2500"),
            color: Colors.indigoAccent,
            strokeWidth: 4,
          ),
          EquationConfig(
            inequality: InequalityType.none,
            // maxX: 100,
            // minX: -100,
            function: EquationParser.parse("40*cos(x/40) - y"),
            color: Colors.pinkAccent,
            strokeWidth: 13,
          ),
        ],
      ),
    );
  }

  // Widget _buildExample() {
  //   switch (_exampleIndex) {
  //     case 0:
  //       return _buildCartesianExample();
  //     case 1:
  //       return _buildPolarExample();
  //     case 2:
  //       return _buildInequalityExample();
  //     default:
  //       return const Center(child: Text('Example not found'));
  //   }
  // }

  // Widget _buildCartesianExample() {
  //   return EquationPainter(
  //     key: const ValueKey('cartesian'),
  //     unitsPerSquare: 10,
  //     interactive: true,
  //     showHint: false,
  //     showGrid: true,
  //     showAxis: true,
  //     showAxisLabel: true,
  //     labelColor: Colors.white70,
  //     onPointTapped: (x, y, config) {
  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text(
  //             'Tapped: (x: $x, y: $y) on equation with type: ${config.type}',
  //           ),
  //           duration: const Duration(seconds: 1),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     },
  //     equations: [
  //       EquationConfig(
  //         function: (x, y) => x * x + y * y - 25,
  //         color: Colors.indigoAccent,
  //         strokeWidth: 4,
  //       ),
  //       EquationConfig(
  //         inequality: InequalityType.none,
  //         maxX: 100,
  //         minX: -100,
  //         function: (x, y) => sin(x) - y,
  //         color: Colors.pinkAccent,
  //         strokeWidth: 3,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildPolarExample() {
  //   return EquationPainter(
  //     key: const ValueKey('polar'),
  //     unitsPerSquare: 5,
  //     interactive: true,
  //     showGrid: true,
  //     showAxis: true,

  //     showAxisLabel: true,
  //     labelColor: Colors.white70,
  //     onPointTapped: (x, y, config) {
  //       // final r = sqrt(x * x + y * y);
  //       // final theta = atan2(y, x);

  //       ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(
  //           content: Text('Polar: (r: , θ: rad)'),
  //           duration: const Duration(seconds: 1),
  //           behavior: SnackBarBehavior.floating,
  //         ),
  //       );
  //     },
  //     equations: [
  //       EquationConfig(
  //         inequality: InequalityType.lessThanOrEqual,
  //         type: EquationType.polar,
  //         function: (r, theta) => tan(theta) - 4 * cos(2 * 600 * r),
  //         color: Colors.cyanAccent,
  //         strokeWidth: 3,
  //         animationType: AnimationType.radial,
  //       ),
  //     ],
  //   );
  // }

  // Widget _buildInequalityExample() {
  //   return EquationPainter(
  //     key: const ValueKey('inequality'),
  //     unitsPerSquare: 10,
  //     interactive: false,
  //     showGrid: true,
  //     showAxis: true,
  //     onPointTapped: (x, y, config) {
  //       print(
  //         'Tapped point: (x: $x, y: $y) on equation with inequality: ${config.inequality}',
  //       );
  //     },

  //     showAxisLabel: true,
  //     labelColor: Colors.white70,
  //     equations: [
  //       EquationConfig(
  //         function: (x, y) => y - x,
  //         inequality: InequalityType.greaterThanOrEqual,
  //         color: Colors.greenAccent,
  //         fillOpacity: 0.2,
  //       ),
  //       // EquationConfig(
  //       //   function: (x, y) => 16 - (x * x + y * y),
  //       //   inequality: InequalityType.greaterThanOrEqual,
  //       //   color: Colors.orangeAccent,
  //       //   fillOpacity: 0.3,
  //       // ),
  //       // EquationConfig(
  //       //   function: (x, y) => x * x + y * y - 16,
  //       //   color: Colors.orangeAccent,
  //       //   strokeWidth: 2,
  //       // ),
  //     ],
  //   );
  // }
}
