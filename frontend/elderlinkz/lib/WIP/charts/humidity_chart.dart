import 'package:elderlinkz/classes/humidity_data.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HumidityChart extends StatelessWidget {
  const HumidityChart({
    super.key,
    required this.data,
  });

  final List<HumidityData> data;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(
        left: 5,
        right: 5,
        top: .2 * screenSize.height,
      ),
      child: BarChart(
        BarChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barTouchData: BarTouchData(
            touchTooltipData: BarTouchTooltipData(
              tooltipBgColor: colorScheme.onSecondary
            ),
          ),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          barGroups: data
            .map((dataVal) => BarChartGroupData(
              x: dataVal.x,
              barRods: [ BarChartRodData(toY: dataVal.y) ]
            ))
            .toList()
        ),
      ),
    );
  }
}