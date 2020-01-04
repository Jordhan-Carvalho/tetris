import 'package:flutter/material.dart';

import '../screens/gameScreen.dart';
import './point.dart';

class Block {
  var points = List<Point>(4);
  Point rotationCenter;
  Color color;

  void move(MoveDirection dir) {
    switch (dir) {
      case MoveDirection.LEFT:
        points.forEach((p) => p.x -= 1);
        break;
      case MoveDirection.RIGHT:
        points.forEach((p) => p.x += 1);
        break;
      case MoveDirection.DOWN:
        points.forEach((p) => p.y += 1);
        break;
    }
  }

  void rotateRight() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x - point.y + rotationCenter.y;
      point.y = rotationCenter.y + x - rotationCenter.x;
    });
  }

  void rotateLeft() {
    points.forEach((point) {
      int x = point.x;
      point.x = rotationCenter.x + point.y - rotationCenter.y;
      point.y = rotationCenter.y - x + rotationCenter.x;
    });
  }
}
