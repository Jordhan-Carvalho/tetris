import 'package:flutter/material.dart';
import 'dart:async';

import '../blocks/alivePoint.dart';
import '../helper.dart';
import '../blocks/block.dart';
import '../scoreDisplay.dart';
import '../userInput.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDirection { LEFT, RIGHT, DOWN }

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;

const double WIDTH = 200;
const double HEIGHT = 400;

const double POINT_SIZE = 20; //size in px

const GAME_SPEED = 400; // 2 updates per second
Timer timer;

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var performAction = LastButtonPressed.NONE;
  Block currentBlock;
  List<AlivePoint> alivePoints = List<AlivePoint>();
  var score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void onActionButton(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    timer = new Timer.periodic(Duration(milliseconds: GAME_SPEED), onTimeTick);
  }

  void checkForUserInput() {
    if (performAction != LastButtonPressed.NONE) {
      setState(() {
        switch (performAction) {
          case LastButtonPressed.LEFT:
            currentBlock.move(MoveDirection.LEFT);
            break;
          case LastButtonPressed.RIGHT:
            currentBlock.move(MoveDirection.RIGHT);
            break;
          case LastButtonPressed.ROTATE_LEFT:
            currentBlock.rotateLeft();
            break;
          case LastButtonPressed.ROTATE_RIGHT:
            currentBlock.rotateRight();
            break;
          default:
            break;
        }

        performAction = LastButtonPressed.NONE;
      });
    }
  }

  void saveOldBlock() {
    currentBlock.points.forEach((point) {
      AlivePoint newPoint = AlivePoint(point.x, point.y, currentBlock.color);
      setState(() {
        alivePoints.add(newPoint);
      });
    });
  }

  bool isAboveOldBlock() {
    bool retVal = false;

    alivePoints.forEach((oldPoint) {
      if (oldPoint.checkIfPointsCollide(currentBlock.points)) {
        retVal = true;
      }
    });

    return retVal;
  }

  void removeRow(int row) {
    setState(() {
      alivePoints.removeWhere((point) => point.y == row);

      alivePoints.forEach((point) {
        if (point.y < row) {
          point.y += 1;
        }
      });
      score += 1;
    });
  }

  void removeFullRows() {
    for (int currentRow = 0; currentRow < BOARD_HEIGHT; currentRow++) {
      // loop through all rows (top to bottom)
      int counter = 0;
      alivePoints.forEach((point) {
        if (point.y == currentRow) {
          counter++;
        }
      });

      if (counter >= BOARD_WIDTH) {
        //remove current row
        removeRow(currentRow);
      }
    }
  }

  bool playerLost() {
    bool retVal = false;

    alivePoints.forEach((point) {
      if (point.y <= 0) {
        retVal = true;
      }
    });

    return retVal;
  }

  void onTimeTick(Timer time) {
    if (currentBlock == null || playerLost()) return;

    //remove full rows
    removeFullRows();

    //check if title is already at the bottom
    if (currentBlock.isAtBottom() || isAboveOldBlock()) {
      //save the block
      saveOldBlock();
      //spawn new block
      setState(() {
        currentBlock = getRandomBlock();
      });
    } else {
      setState(() {
        currentBlock.move(MoveDirection.DOWN);
      });

      checkForUserInput();
    }
  }

  Widget drawTestrisBlocks() {
    if (currentBlock == null) return null;

    List<Positioned> visiblePoints = List();

    //currentBlock
    currentBlock.points.forEach((point) {
      Positioned newPoint = Positioned(
        child: generatePoint(currentBlock.color),
        left: point.x * POINT_SIZE,
        top: point.y * POINT_SIZE,
      );
      visiblePoints.add(newPoint);
    });

    //old blocks
    alivePoints.forEach((point) {
      visiblePoints.add(
        Positioned(
          child: generatePoint(point.color),
          left: point.x * POINT_SIZE,
          top: point.y * POINT_SIZE,
        ),
      );
    });

    return Stack(
      children: <Widget>[...visiblePoints],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game ON!!'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back_ios),
            onPressed: () async {
              timer.cancel();
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
        ),
        backgroundColor: Theme.of(context).accentColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: Container(
                width: WIDTH,
                height: HEIGHT,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: (playerLost() == false)
                    ? drawTestrisBlocks()
                    : getGameOverText(score),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ScoreDisplay(score),
                UserInput(onActionButton),
              ],
            ),
          ],
        ));
  }
}
