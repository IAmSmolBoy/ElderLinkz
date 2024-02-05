import 'package:elderlinkz/classes/floor_plan.dart';
import 'package:elderlinkz/widgets/floor_plan_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({ super.key });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final model = Provider.of<FloorPlanModel>(context);

    return Container(
      color: colorScheme.background,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            const FloorPlanWidget(),
            if (!model.touched) IgnorePointer(
              ignoring: true,
              child: Container(
                color: colorScheme.surface.withOpacity(0.85),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.touch_app,
                        color: colorScheme.onSurface,
                        size: 40.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Start by dragging with your fingers',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: colorScheme.onSurface),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}