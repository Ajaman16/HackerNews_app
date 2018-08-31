import 'package:flutter/material.dart';
import 'package:hackernews_app/src/screens/home.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hacker News",
      home: Home(),
    );
  }
}
