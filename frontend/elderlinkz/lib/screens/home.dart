import 'package:elderlinkz/widgets/floor_plan_widget.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({ super.key });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      color: colorScheme.background,
      child: const Center(
        child: FloorPlanWidget(),
      ),
    );
  }
}