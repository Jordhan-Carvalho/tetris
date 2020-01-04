import 'package:flutter/material.dart';
import 'dart:async';

import '../main.dart';
import '../actionButton.dart';
import '../helper.dart';
import '../blocks/block.dart';

enum LastButtonPressed { LEFT, RIGHT, ROTATE_LEFT, ROTATE_RIGHT, NONE }
enum MoveDirection { LEFT, RIGHT, DOWN }

const int BOARD_WIDTH = 10;
const int BOARD_HEIGHT = 20;
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

  void onActionButton(LastButtonPressed newAction) {
    setState(() {
      performAction = newAction;
      print(performAction);
    });
  }

  void startGame() {
    setState(() {
      currentBlock = getRandomBlock();
    });
    timer = new Timer.periodic(Duration(microseconds: GAME_SPEED), onTimeTick);
  }

  void onTimeTick(Timer time) {
    if (currentBlock == null) return;

    setState(() {
      currentBlock.move(MoveDirection.DOWN);
    });
  }

  Widget drawTestrisBlocks() {
    if (currentBlock == null) return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Game ON!!'),
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
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ActionButton(
                  onClicked: onActionButton,
                  buttonIcon: Icon(Icons.arrow_left),
                  nextAction: LastButtonPressed.LEFT,
                ),
                ActionButton(
                  onClicked: onActionButton,
                  buttonIcon: Icon(Icons.arrow_right),
                  nextAction: LastButtonPressed.RIGHT,
                ),
                ActionButton(
                  onClicked: onActionButton,
                  buttonIcon: Icon(Icons.rotate_left),
                  nextAction: LastButtonPressed.ROTATE_LEFT,
                ),
                ActionButton(
                  onClicked: onActionButton,
                  buttonIcon: Icon(Icons.rotate_right),
                  nextAction: LastButtonPressed.ROTATE_RIGHT,
                ),
              ],
            ),
          ],
        ));
  }
}
