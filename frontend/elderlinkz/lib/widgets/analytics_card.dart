import 'package:flutter/material.dart';

class AnalyticsCard extends StatelessWidget {
  const AnalyticsCard({
    super.key,
    required this.variableName,
    required this.variableValue,
    this.child
  });

  final String variableName, variableValue;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    Size screenSize = MediaQuery.of(context).size;

    return Card(
      elevation: 10,
      shadowColor: colorScheme.onBackground,
      child: SizedBox(
        height: .4 * screenSize.height,
        width: .4 * screenSize.width,
        child: Stack(
          children: [
            if (child != null) child!,
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(variableName,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  Text(variableValue,
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}