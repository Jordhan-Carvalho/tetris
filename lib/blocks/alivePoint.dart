import 'package:flutter/material.dart';

import './point.dart';

class AlivePoint extends Point {
  Color color;

  AlivePoint(int x, int y, this.color) : super(x, y);

  bool checkIfPointsCollide(List<Point> pointList) {
    bool retVal = false;

    pointList.forEach((pointToCheck) {
      if (pointToCheck.x == x && pointToCheck.y == y - 1) {
        retVal = true;
      }
    });

    return retVal;
  }
}
