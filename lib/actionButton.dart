import 'package:flutter/material.dart';

import './screens/gameScreen.dart';

class ActionButton extends StatelessWidget {
  final Function onClicked;
  final Icon buttonIcon;
  final LastButtonPressed nextAction;
  ActionButton({this.buttonIcon, this.onClicked, this.nextAction});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: RaisedButton(
          onPressed: () => onClicked(nextAction),
          child: buttonIcon,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }
}
