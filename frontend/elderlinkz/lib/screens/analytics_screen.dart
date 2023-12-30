import 'package:elderlinkz/charts/gsr_chart.dart';
import 'package:elderlinkz/charts/humidity_chart.dart';
import 'package:elderlinkz/classes/humidity_data.dart';
import 'package:elderlinkz/widgets/analytics_card.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({ super.key });

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  List<FlSpot> gsrData = const [
    FlSpot(0, 0),
    FlSpot(5, 10),
    FlSpot(10, 15),
    FlSpot(15, 10),
    FlSpot(20, 20),
    FlSpot(25, 5),
    FlSpot(30, 30),
    FlSpot(35, 20),
    FlSpot(40, 0),
  ];
  List<HumidityData> humidityData = const [
    HumidityData(x: 0, y: 0),
    HumidityData(x: 5,  y: 10),
    HumidityData(x: 10, y: 15),
    HumidityData(x: 15, y: 10),
    HumidityData(x: 20, y: 20),
    HumidityData(x: 25, y: 5),
    HumidityData(x: 30, y: 30),
    HumidityData(x: 35, y: 20),
    HumidityData(x: 40, y: 0),
  ];


  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnalyticsCard(
                  variableName: "GSR",
                  variableValue: "${(
                    gsrData
                      .map((data) => data.y)
                      .reduce((v, e) => v + e) / gsrData.length)
                      .toStringAsFixed(2)}S",
                  child: GSRChart(
                    data: gsrData,
                  ),
                ),
                AnalyticsCard(
                  variableName: "Humidity",
                  variableValue: "${(
                    humidityData
                      .map((data) => data.y)
                      .reduce((v, e) => v + e) / gsrData.length)
                      .toStringAsFixed(2)}%",
                  child: HumidityChart(
                    data: humidityData,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnalyticsCard(
                  variableName: "GSR",
                  variableValue: "-2S",
                  child: Center(
                    child: Text("3"),
                  ),
                ),
                AnalyticsCard(
                  variableName: "GSR",
                  variableValue: "-2S",
                  child: Center(
                    child: Text("4"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20,),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                AnalyticsCard(
                  variableName: "GSR",
                  variableValue: "-2S",
                  child: Center(
                    child: Text("3"),
                  ),
                ),
                AnalyticsCard(
                  variableName: "GSR",
                  variableValue: "-2S",
                  child: Center(
                    child: Text("4"),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}