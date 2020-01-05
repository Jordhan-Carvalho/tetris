import 'package:flutter/material.dart';

import './actionButton.dart';
import './screens/gameScreen.dart';

class UserInput extends StatelessWidget {
  final Function onActionButtonPressed;
  UserInput(this.onActionButtonPressed);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          children: <Widget>[
            ActionButton(
              onClicked: onActionButtonPressed,
              buttonIcon: Icon(Icons.rotate_left),
              nextAction: LastButtonPressed.ROTATE_LEFT,
            ),
            ActionButton(
              onClicked: onActionButtonPressed,
              buttonIcon: Icon(Icons.rotate_right),
              nextAction: LastButtonPressed.ROTATE_RIGHT,
            ),
          ],
        ),
        Row(
          children: <Widget>[
            ActionButton(
              onClicked: onActionButtonPressed,
              buttonIcon: Icon(Icons.arrow_left),
              nextAction: LastButtonPressed.LEFT,
            ),
            ActionButton(
              onClicked: onActionButtonPressed,
              buttonIcon: Icon(Icons.arrow_right),
              nextAction: LastButtonPressed.RIGHT,
            ),
          ],
        ),
      ],
    );
  }
}
