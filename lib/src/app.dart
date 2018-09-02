import 'package:flutter/material.dart';
import 'package:hackernews_app/src/screens/home.dart';
import '../src/blocks/stories_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return StoriesProvider(
      child: MaterialApp(
        title: "Hacker News",
        home: Home(),
        debugShowCheckedModeBanner: false,
      ),
    );

  }
}
