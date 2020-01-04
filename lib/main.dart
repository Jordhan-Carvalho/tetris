import 'package:flutter/material.dart';

import './screens/gameScreen.dart';
import './menu.dart';

const double WIDTH = 300;
const double HEIGHT = 400;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.cyan,
      ),
      home: Home(title: 'Main Menu'),
      routes: {
        '/gameScreen': (ctx) => GameScreen(),
      },
    );
  }
}

class Home extends StatelessWidget {
  final String title;
  const Home({this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      backgroundColor: Theme.of(context).accentColor,
      body: Menu(),
    );
  }
}
