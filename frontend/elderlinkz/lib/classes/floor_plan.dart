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

  double x = 0.0;
  double y = 0.0;

  Pos(this.x, this.y);

  static Pos fromMap(Map data) =>
    Pos(
      data["x"],
      data["y"]
    );

  Map<String, double> toMap(Map data) =>
    {
      "x": x,
      "y": y
    };

}

class Ward {

  // final String location;
  final int name;
  // final double status;
  final Pos position;
  // final int tile;

  const Ward({
    // required this.location,
    required this.name,
    // required this.status,
    required this.position,
    // required this.tile,
  });

  static Ward fromMap(Map data) =>
    Ward(
      // location: data["location"] ?? 'No location.',
      name: data["name"] ?? 'No name.',
      // status: data["status"] ?? 0.0,
      position: Pos.fromMap(data["position"] ?? { "x": 0, "y": 0 }),
      // tile: data["tile"] ?? 0
    );

}


class FloorPlanModel extends ChangeNotifier {

  double scale = 1.0;
  double previousScale = 1.0;
  Pos pos = Pos(0.0, 0.0);
  Pos previousPos = Pos(0.0, 0.0);
  Pos endPos = Pos(0.0, 0.0);
  bool isScaled = false;
  bool hasTouched = false;

  void handleDragScaleStart(ScaleStartDetails details) {
    hasTouched = true;
    previousScale = scale;
    previousPos.x = (details.focalPoint.dx / scale) - endPos.x;
    previousPos.y = (details.focalPoint.dy / scale) - endPos.y;
    notifyListeners();
  }

  void handleDragScaleUpdate(ScaleUpdateDetails details) {
    scale = previousScale * details.scale;
    isScaled = scale > 2.0;

    if (scale < 1.0) {
      scale = 1.0;
    } else if (scale > 4.0) {
      scale = 4.0;
    } else if (previousScale == scale) {
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