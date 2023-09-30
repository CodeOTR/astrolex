import 'dart:math';

import 'package:astrolex/app/text_theme.dart';
import 'package:astrolex/app/theme.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:openalex/models/models.dart';

class TrendChart extends StatelessWidget {
   const TrendChart({Key? key, required this.countsByYear}) : super(key: key);

  final List<CountByYear>? countsByYear;

  @override
  Widget build(BuildContext context) {
    if (countsByYear == null || countsByYear!.isEmpty) {
      return Center(child: Text("No publication data available for this concept.", style: context.bodyMedium.secondary));
    }

    // Convert countsByYear to FlSpot for chart
    List<FlSpot> spots = countsByYear!.map((e) {
      return FlSpot(e.year?.toDouble() ?? 0, (e.worksCount ?? 0).toDouble());
    }).toList();

    return LineChart(
      LineChartData(
        gridData: const FlGridData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 36,
                getTitlesWidget: (value, meta) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Transform.rotate(angle: -45 * pi / 180, child: Text(value.toInt().toString(), style: context.bodySmall.secondary)),
                  );
                },
              )),
          topTitles: const AxisTitles(axisNameWidget: SizedBox.shrink(), axisNameSize: 36),
          leftTitles: const AxisTitles(axisNameWidget: SizedBox.shrink()),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(
              color: context.primary,
              width: 2,
            ),
            left: const BorderSide(color: Colors.transparent),
            right: const BorderSide(color: Colors.transparent),
            top: const BorderSide(color: Colors.transparent),
          ),
        ),
        minX: spots.map((e) => e.x).reduce((value, element) => value < element ? value : element),
        maxX: spots.map((e) => e.x).reduce((value, element) => value > element ? value : element),
        minY: 0,
        maxY: spots.map((e) => e.y).reduce((value, element) => value > element ? value : element),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: context.primary,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(show: false),
            barWidth: 4,
          ),
        ],
      ),
    );
  }
}
