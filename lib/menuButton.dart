import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final Function onClick;
  const MenuButton({this.onClick});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      height: 60,
      minWidth: 200,
      child: RaisedButton(
        onPressed: onClick,
        child: const Icon(Icons.play_arrow),
        color: Theme.of(context).primaryColorLight,
      ),
    );
  }
}
