// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class ChartPoint {
//   final DateTime date;
//   final double desktop;
//   final double mobile;

//   ChartPoint({required this.date, required this.desktop, required this.mobile});
// }

// final List<ChartPoint> chartData = [
//   ChartPoint(date: DateTime(2024, 1, 1), desktop: 220, mobile: 180),
//   ChartPoint(date: DateTime(2024, 1, 2), desktop: 245, mobile: 195),
//   ChartPoint(date: DateTime(2024, 1, 3), desktop: 210, mobile: 170),
//   ChartPoint(date: DateTime(2024, 1, 4), desktop: 280, mobile: 220),
//   ChartPoint(date: DateTime(2024, 1, 5), desktop: 310, mobile: 250),
//   ChartPoint(date: DateTime(2024, 1, 6), desktop: 330, mobile: 290),
//   ChartPoint(date: DateTime(2024, 1, 7), desktop: 295, mobile: 240),
//   ChartPoint(date: DateTime(2024, 1, 8), desktop: 360, mobile: 310),
//   ChartPoint(date: DateTime(2024, 1, 9), desktop: 390, mobile: 340),
//   ChartPoint(date: DateTime(2024, 1, 10), desktop: 410, mobile: 360),

//   ChartPoint(date: DateTime(2024, 1, 11), desktop: 430, mobile: 390),
//   ChartPoint(date: DateTime(2024, 1, 12), desktop: 470, mobile: 420),
//   ChartPoint(date: DateTime(2024, 1, 13), desktop: 455, mobile: 400),
//   ChartPoint(date: DateTime(2024, 1, 14), desktop: 390, mobile: 350),
//   ChartPoint(date: DateTime(2024, 1, 15), desktop: 370, mobile: 320),
//   ChartPoint(date: DateTime(2024, 1, 16), desktop: 345, mobile: 300),
//   ChartPoint(date: DateTime(2024, 1, 17), desktop: 330, mobile: 285),
//   ChartPoint(date: DateTime(2024, 1, 18), desktop: 355, mobile: 295),
//   ChartPoint(date: DateTime(2024, 1, 19), desktop: 390, mobile: 330),
//   ChartPoint(date: DateTime(2024, 1, 20), desktop: 420, mobile: 360),

//   ChartPoint(date: DateTime(2024, 1, 21), desktop: 450, mobile: 390),
//   ChartPoint(date: DateTime(2024, 1, 22), desktop: 480, mobile: 420),
//   ChartPoint(date: DateTime(2024, 1, 23), desktop: 495, mobile: 435),
//   ChartPoint(date: DateTime(2024, 1, 24), desktop: 460, mobile: 410),
//   ChartPoint(date: DateTime(2024, 1, 25), desktop: 430, mobile: 380),
//   ChartPoint(date: DateTime(2024, 1, 26), desktop: 405, mobile: 350),
//   ChartPoint(date: DateTime(2024, 1, 27), desktop: 370, mobile: 315),
//   ChartPoint(date: DateTime(2024, 1, 28), desktop: 340, mobile: 290),
//   ChartPoint(date: DateTime(2024, 1, 29), desktop: 320, mobile: 270),
//   ChartPoint(date: DateTime(2024, 1, 30), desktop: 295, mobile: 245),

//   ChartPoint(date: DateTime(2024, 1, 31), desktop: 280, mobile: 235),
//   ChartPoint(date: DateTime(2024, 2, 1), desktop: 300, mobile: 255),
//   ChartPoint(date: DateTime(2024, 2, 2), desktop: 325, mobile: 275),
//   ChartPoint(date: DateTime(2024, 2, 3), desktop: 355, mobile: 305),
//   ChartPoint(date: DateTime(2024, 2, 4), desktop: 390, mobile: 335),
//   ChartPoint(date: DateTime(2024, 2, 5), desktop: 425, mobile: 365),
//   ChartPoint(date: DateTime(2024, 2, 6), desktop: 460, mobile: 395),
//   ChartPoint(date: DateTime(2024, 2, 7), desktop: 490, mobile: 425),
//   ChartPoint(date: DateTime(2024, 2, 8), desktop: 510, mobile: 450),
//   ChartPoint(date: DateTime(2024, 2, 9), desktop: 530, mobile: 470),

//   ChartPoint(date: DateTime(2024, 2, 10), desktop: 520, mobile: 460),
//   ChartPoint(date: DateTime(2024, 2, 11), desktop: 500, mobile: 440),
//   ChartPoint(date: DateTime(2024, 2, 12), desktop: 470, mobile: 410),
//   ChartPoint(date: DateTime(2024, 2, 13), desktop: 445, mobile: 385),
//   ChartPoint(date: DateTime(2024, 2, 14), desktop: 420, mobile: 360),
//   ChartPoint(date: DateTime(2024, 2, 15), desktop: 395, mobile: 340),
//   ChartPoint(date: DateTime(2024, 2, 16), desktop: 370, mobile: 315),
//   ChartPoint(date: DateTime(2024, 2, 17), desktop: 350, mobile: 295),
//   ChartPoint(date: DateTime(2024, 2, 18), desktop: 330, mobile: 280),
//   ChartPoint(date: DateTime(2024, 2, 19), desktop: 315, mobile: 265),

//   ChartPoint(date: DateTime(2024, 2, 20), desktop: 340, mobile: 285),
//   ChartPoint(date: DateTime(2024, 2, 21), desktop: 365, mobile: 305),
//   ChartPoint(date: DateTime(2024, 2, 22), desktop: 395, mobile: 330),
//   ChartPoint(date: DateTime(2024, 2, 23), desktop: 430, mobile: 360),
//   ChartPoint(date: DateTime(2024, 2, 24), desktop: 465, mobile: 395),
//   ChartPoint(date: DateTime(2024, 2, 25), desktop: 495, mobile: 425),
//   ChartPoint(date: DateTime(2024, 2, 26), desktop: 520, mobile: 450),
//   ChartPoint(date: DateTime(2024, 2, 27), desktop: 545, mobile: 475),
//   ChartPoint(date: DateTime(2024, 2, 28), desktop: 560, mobile: 490),
//   ChartPoint(date: DateTime(2024, 2, 29), desktop: 540, mobile: 470),

//   ChartPoint(date: DateTime(2024, 3, 1), desktop: 510, mobile: 440),
//   ChartPoint(date: DateTime(2024, 3, 2), desktop: 485, mobile: 420),
//   ChartPoint(date: DateTime(2024, 3, 3), desktop: 455, mobile: 395),
//   ChartPoint(date: DateTime(2024, 3, 4), desktop: 430, mobile: 370),
//   ChartPoint(date: DateTime(2024, 3, 5), desktop: 405, mobile: 350),
//   ChartPoint(date: DateTime(2024, 3, 6), desktop: 380, mobile: 325),
//   ChartPoint(date: DateTime(2024, 3, 7), desktop: 355, mobile: 300),
//   ChartPoint(date: DateTime(2024, 3, 8), desktop: 330, mobile: 280),
//   ChartPoint(date: DateTime(2024, 3, 9), desktop: 315, mobile: 265),
//   ChartPoint(date: DateTime(2024, 3, 10), desktop: 340, mobile: 290),

//   ChartPoint(date: DateTime(2024, 3, 11), desktop: 365, mobile: 315),
//   ChartPoint(date: DateTime(2024, 3, 12), desktop: 395, mobile: 340),
//   ChartPoint(date: DateTime(2024, 3, 13), desktop: 430, mobile: 370),
//   ChartPoint(date: DateTime(2024, 3, 14), desktop: 465, mobile: 400),
//   ChartPoint(date: DateTime(2024, 3, 15), desktop: 495, mobile: 425),
//   ChartPoint(date: DateTime(2024, 3, 16), desktop: 520, mobile: 450),
//   ChartPoint(date: DateTime(2024, 3, 17), desktop: 545, mobile: 470),
//   ChartPoint(date: DateTime(2024, 3, 18), desktop: 565, mobile: 490),
//   ChartPoint(date: DateTime(2024, 3, 19), desktop: 590, mobile: 515),
//   ChartPoint(date: DateTime(2024, 3, 20), desktop: 610, mobile: 530),

//   ChartPoint(date: DateTime(2024, 3, 21), desktop: 585, mobile: 505),
//   ChartPoint(date: DateTime(2024, 3, 22), desktop: 555, mobile: 480),
//   ChartPoint(date: DateTime(2024, 3, 23), desktop: 525, mobile: 450),
//   ChartPoint(date: DateTime(2024, 3, 24), desktop: 495, mobile: 425),
//   ChartPoint(date: DateTime(2024, 3, 25), desktop: 465, mobile: 395),
//   ChartPoint(date: DateTime(2024, 3, 26), desktop: 440, mobile: 375),
//   ChartPoint(date: DateTime(2024, 3, 27), desktop: 415, mobile: 350),
//   ChartPoint(date: DateTime(2024, 3, 28), desktop: 390, mobile: 330),
//   ChartPoint(date: DateTime(2024, 3, 29), desktop: 365, mobile: 310),
//   ChartPoint(date: DateTime(2024, 3, 30), desktop: 340, mobile: 290),

//   ChartPoint(date: DateTime(2024, 3, 31), desktop: 360, mobile: 305),
//   ChartPoint(date: DateTime(2024, 4, 1), desktop: 385, mobile: 325),
//   ChartPoint(date: DateTime(2024, 4, 2), desktop: 415, mobile: 350),
//   ChartPoint(date: DateTime(2024, 4, 3), desktop: 445, mobile: 375),
//   ChartPoint(date: DateTime(2024, 4, 4), desktop: 475, mobile: 400),
//   ChartPoint(date: DateTime(2024, 4, 5), desktop: 505, mobile: 430),
//   ChartPoint(date: DateTime(2024, 4, 6), desktop: 530, mobile: 455),
//   ChartPoint(date: DateTime(2024, 4, 7), desktop: 555, mobile: 480),
//   ChartPoint(date: DateTime(2024, 4, 8), desktop: 580, mobile: 505),
//   ChartPoint(date: DateTime(2024, 4, 9), desktop: 605, mobile: 525),

//   ChartPoint(date: DateTime(2024, 4, 10), desktop: 625, mobile: 545),
//   ChartPoint(date: DateTime(2024, 4, 11), desktop: 600, mobile: 520),
//   ChartPoint(date: DateTime(2024, 4, 12), desktop: 570, mobile: 495),
//   ChartPoint(date: DateTime(2024, 4, 13), desktop: 540, mobile: 465),
//   ChartPoint(date: DateTime(2024, 4, 14), desktop: 510, mobile: 440),
//   ChartPoint(date: DateTime(2024, 4, 15), desktop: 480, mobile: 410),
//   ChartPoint(date: DateTime(2024, 4, 16), desktop: 455, mobile: 390),
//   ChartPoint(date: DateTime(2024, 4, 17), desktop: 430, mobile: 365),
//   ChartPoint(date: DateTime(2024, 4, 18), desktop: 405, mobile: 345),
//   ChartPoint(date: DateTime(2024, 4, 19), desktop: 380, mobile: 320),

//   ChartPoint(date: DateTime(2024, 4, 20), desktop: 360, mobile: 300),
//   ChartPoint(date: DateTime(2024, 4, 21), desktop: 390, mobile: 330),
//   ChartPoint(date: DateTime(2024, 4, 22), desktop: 420, mobile: 355),
//   ChartPoint(date: DateTime(2024, 4, 23), desktop: 455, mobile: 385),
//   ChartPoint(date: DateTime(2024, 4, 24), desktop: 490, mobile: 415),
//   ChartPoint(date: DateTime(2024, 4, 25), desktop: 525, mobile: 445),
//   ChartPoint(date: DateTime(2024, 4, 26), desktop: 560, mobile: 475),
//   ChartPoint(date: DateTime(2024, 4, 27), desktop: 590, mobile: 500),
//   ChartPoint(date: DateTime(2024, 4, 28), desktop: 620, mobile: 530),
//   ChartPoint(date: DateTime(2024, 4, 29), desktop: 650, mobile: 560),
//   ChartPoint(date: DateTime(2024, 4, 30), desktop: 680, mobile: 590),
// ];

// class InteractiveAreaChart extends StatefulWidget {
//   const InteractiveAreaChart({super.key});

//   @override
//   State<InteractiveAreaChart> createState() => _InteractiveAreaChartState();
// }

// class _InteractiveAreaChartState extends State<InteractiveAreaChart> {
//   String range = "90d";

//   List<ChartPoint> get filtered {
//     final reference = chartData.last.date; // Apr 30, 2024
//     int days = switch (range) {
//       "30d" => 30,
//       "7d" => 7,
//       _ => 90,
//     };
//     final start = reference.subtract(Duration(days: days));
//     return chartData.where((e) => !e.date.isBefore(start)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       child: Column(
//         children: [
//           DropdownButton<String>(
//             value: range,
//             items: const [
//               DropdownMenuItem(value: "90d", child: Text("Last 3 months")),
//               DropdownMenuItem(value: "30d", child: Text("Last 30 days")),
//               DropdownMenuItem(value: "7d", child: Text("Last 7 days")),
//             ],
//             onChanged: (v) {
//               setState(() {
//                 range = v!;
//               });
//             },
//           ),

//           SizedBox(
//             height: 280,
//             child: LineChart(
//               _chartData(filtered),
//               // swapAnimationDuration:
//               //     const Duration(milliseconds: 300),
//               // swapAnimationCurve: Curves.easeInOut,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   LineChartData _chartData(List<ChartPoint> data) {
//     return LineChartData(
//       gridData: FlGridData(drawVerticalLine: false),

//       borderData: FlBorderData(show: false),

//       lineTouchData: LineTouchData(
//         handleBuiltInTouches: true,

//         touchTooltipData: LineTouchTooltipData(
//           // tooltipRoundedRadius: 8,
//           tooltipBorderRadius: BorderRadius.all(Radius.circular(25)),
//           getTooltipItems: (spots) {
//             return spots.map((spot) {
//               final point = data[spot.x.toInt()];

//               return LineTooltipItem(
//                 DateFormat("MMM d").format(point.date),
//                 const TextStyle(fontWeight: FontWeight.bold),
//                 children: [
//                   TextSpan(text: "\nDesktop: ${point.desktop.toInt()}"),
//                   TextSpan(text: "\nMobile: ${point.mobile.toInt()}"),
//                 ],
//               );
//             }).toList();
//           },
//         ),
//       ),

//       titlesData: FlTitlesData(
//         topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
//         rightTitles: const AxisTitles(
//           sideTitles: SideTitles(showTitles: false),
//         ),

//         leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

//         bottomTitles: AxisTitles(
//           sideTitles: SideTitles(
//             showTitles: true,
//             interval: 10,

//             getTitlesWidget: (value, meta) {
//               final i = value.toInt();

//               if (i >= data.length) {
//                 return const SizedBox();
//               }

//               return Text(
//                 DateFormat("MMM d").format(data[i].date),
//                 style: const TextStyle(fontSize: 11),
//               );
//             },
//           ),
//         ),
//       ),

//       lineBarsData: [
//         /// Mobile
//         LineChartBarData(
//           isCurved: true,

//           curveSmoothness: .35,

//           color: Colors.orange,

//           barWidth: 2,

//           spots: List.generate(
//             data.length,
//             (i) => FlSpot(i.toDouble(), data[i].mobile),
//           ),

//           dotData: const FlDotData(show: false),

//           belowBarData: BarAreaData(
//             show: true,

//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.orange.withOpacity(.8),
//                 Colors.orange.withOpacity(.1),
//               ],
//             ),
//           ),
//         ),

//         /// Desktop
//         LineChartBarData(
//           isCurved: true,

//           curveSmoothness: .35,

//           color: Colors.blue,

//           barWidth: 2,

//           spots: List.generate(
//             data.length,
//             (i) => FlSpot(i.toDouble(), data[i].desktop),
//           ),

//           dotData: const FlDotData(show: false),

//           belowBarData: BarAreaData(
//             show: true,

//             gradient: LinearGradient(
//               begin: Alignment.topCenter,
//               end: Alignment.bottomCenter,
//               colors: [
//                 Colors.blue.withOpacity(.8),
//                 Colors.blue.withOpacity(.1),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
