import 'package:flutter/material.dart';
import 'dart:math';

import './screens/gameScreen.dart';
import './blocks/block.dart';
import './blocks/iblock.dart';
import './blocks/jblock.dart';
import './blocks/lblock.dart';
import './blocks/sblock.dart';
import './blocks/sqblock.dart';
import './blocks/tblock.dart';
import './blocks/zblock.dart';

Block getRandomBlock() {
  int randomNr = Random().nextInt(7);
  switch (randomNr) {
    case 0:
      return IBlock(BOARD_WIDTH);
      break;
    case 1:
      return JBlock(BOARD_WIDTH);
      break;
    case 2:
      return LBlock(BOARD_WIDTH);
      break;
    case 3:
      return SBlock(BOARD_WIDTH);
      break;
    case 4:
      return SquareBlock(BOARD_WIDTH);
      break;
    case 5:
      return TBlock(BOARD_WIDTH);
      break;
    case 6:
      return ZBlock(BOARD_WIDTH);
      break;
  }
}

Widget generatePoint(Color color) {
  return Container(
    width: POINT_SIZE,
    height: POINT_SIZE,
    decoration: BoxDecoration(
      color: color,
      shape: BoxShape.rectangle,
    ),
  );
}
