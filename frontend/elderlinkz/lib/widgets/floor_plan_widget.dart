import 'package:elderlinkz/classes/floor_plan.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class FloorPlanWidget extends StatefulWidget {
  const FloorPlanWidget({super.key});

  @override
  State<FloorPlanWidget> createState() => _FloorPlanWidgetState();
}

class _FloorPlanWidgetState extends State<FloorPlanWidget> {
  @override
  Widget build(BuildContext context) {
    
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final Size size = MediaQuery.of(context).size;
    final model = Provider.of<FloorPlanModel>(context);

    final gestures = {
      DragAndScale: GestureRecognizerFactoryWithHandlers<DragAndScale>(
        () => DragAndScale(),
        (DragAndScale instance) {
          instance
            ..onStart = (details) { model.handleDragScaleStart(details); }
            ..onUpdate = (details) { model.handleDragScaleUpdate(details); }
            ..onEnd = (_) { model.handleDragScaleEnd(); };
        },
      )
    };

    final AlignmentGeometry alignment = FractionalOffset
      .fromOffsetAndRect(
        Offset(
          size.width / 2,
          size.height / 2,
        ),
        Rect
          .fromLTRB(
            0.0,
            0.0,
            size.width,
            size.height,
          ),
      );

    final Matrix4 transform = Matrix4
      .diagonal3(
        Vector3(
          model.scale,
          model.scale,
          model.scale,
        ),
      )..translate(
        model.pos.x,
        model.pos.y,
      );
    
    return RawGestureDetector(
      gestures: gestures,
      child: Transform(
        alignment: alignment,
        transform: transform,
        child: ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: [
                SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Center(
                    child: Stack(
                      children: [
                        Image.asset("assets/images/floor_plan.jpg"),
                        ...List.generate(
                          wardData.length,
                          (idx) {
                            return Transform.translate(
                              offset: Offset(
                                size.width * wardData[idx].position.x,
                                size.width * wardData[idx].position.y,
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 5.0,
                                    child: Center(
                                      child: Icon(
                                        Icons.elderly,
                                        color: colorScheme.onError,
                                        size: 7,
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    transform: Matrix4
                                      .identity()
                                      ..translate(10.0),
                                    child: Text(
                                      wardData[idx].name.toString(),
                                      style: TextStyle(
                                        fontSize: 6.0,
                                        color: colorScheme.primary,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ]
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}







// Classes
class DragAndScale extends ScaleGestureRecognizer {

  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }

}

class RemoveScrollGlow extends ScrollBehavior {

  @override
  Widget buildOverscrollIndicator(
      BuildContext context,
      Widget child,
      ScrollableDetails details
    ) => child;

}