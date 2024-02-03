import 'package:elderlinkz/classes/colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class GSRChart extends StatelessWidget {
  const GSRChart({
    super.key,
    required this.data
  });

  final List<FlSpot> data;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(
        bottom: 15,
        top: .2 * screenSize.height,
      ),
      child: LineChart(
        LineChartData(
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: colorScheme.onSecondary
            ),
          ),
          titlesData: const FlTitlesData(
            leftTitles: AxisTitles(),
            topTitles: AxisTitles(),
            bottomTitles: AxisTitles(),
            rightTitles: AxisTitles(),
          ),
          lineBarsData: [
            LineChartBarData(
              isCurved: true,
              isStrokeCapRound: true,
              spots: data,
              color: colorScheme.secondary,
              dotData: const FlDotData(show: false,),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    .25,
                    .75,
                    1
                  ],
                  colors: [
                    AppColors.secondaryGreen,
                    AppColors.secondaryGreen.withOpacity(.25),
                    colorScheme.surface.withOpacity(.25)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}