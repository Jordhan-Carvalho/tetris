import 'package:flutter/material.dart';
import './menuButton.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  void onPlayClick() {
    Navigator.pushNamed(context, '/gameScreen');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Tetris',
            style: TextStyle(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColorDark,
              shadows: [
                Shadow(
                  blurRadius: 8.0,
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
          MenuButton(
            onClick: onPlayClick,
          )
        ],
      ),
    );
  }
}
