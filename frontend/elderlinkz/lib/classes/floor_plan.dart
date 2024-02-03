import 'package:flutter/material.dart';

final List<Ward> wardData = [
  Ward(
    name: 1,
    position: Pos(.2, .2),
  ),
  Ward(
    name: 2,
    position: Pos(.275, .2),
  ),
  Ward(
    name: 3,
    position: Pos(.35, .2),
  ),
  Ward(
    name: 4,
    position: Pos(.425, .2),
  ),
  Ward(
    name: 5,
    position: Pos(.5, .2),
  ),
  Ward(
    name: 6,
    position: Pos(.575, .2),
  ),
  Ward(
    name: 7,
    position: Pos(.15, .4),
  ),
  Ward(
    name: 8,
    position: Pos(.15, .475),
  ),
  Ward(
    name: 9,
    position: Pos(.15, .55),
  ),
  Ward(
    name: 10,
    position: Pos(.65, .4),
  ),
  Ward(
    name: 11,
    position: Pos(.65, .475),
  ),
  Ward(
    name: 12,
    position: Pos(.65, .55),
  ),
];

class Pos {

  double x;
  double y;

  Pos(this.x, this.y);

}

class Ward {

  final int name;
  final Pos position;

  const Ward({
    required this.name,
    required this.position,
  });

}


class FloorPlanModel extends ChangeNotifier {

  double scale = 1.0;
  double previousScale = 1.0;
  Pos pos = Pos(0.0, 0.0);
  Pos previousPos = Pos(0.0, 0.0);
  Pos endPos = Pos(0.0, 0.0);
  bool isScaled = false;
  bool touched = false;

  void handleDragScaleStart(ScaleStartDetails details) {

    Offset touchPoint = details.focalPoint;

    touched = true;
    previousScale = scale;
    previousPos
      ..x = (touchPoint.dx / scale) - endPos.x
      ..y = (touchPoint.dy / scale) - endPos.y;

    notifyListeners();

  }

  void handleDragScaleUpdate(ScaleUpdateDetails details) {

    scale = previousScale * details.scale;
    isScaled = scale > 2.0;

    if (scale < 1.0) { scale = 1.0; }
    else if (scale > 4.0) { scale = 4.0; }
    else if (previousScale == scale) {

      pos.x = (details.focalPoint.dx / scale) - previousPos.x;
      pos.y = (details.focalPoint.dy / scale) - previousPos.y;
    }

    notifyListeners();

  }

  void reset() {

    scale = 1.0;
    previousScale = 1.0;
    pos = Pos(0.0, 0.0);
    previousPos = Pos(0.0, 0.0);
    endPos = Pos(0.0, 0.0);
    isScaled = false;

    notifyListeners();

  }

  void handleDragScaleEnd() {

    previousScale = 1.0;
    endPos = pos;
    notifyListeners();

  }

}