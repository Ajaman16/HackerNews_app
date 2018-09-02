import 'package:flutter/material.dart';
import 'package:hackernews_app/src/blocks/stories_block.dart';
import 'dart:async';
import '../blocks/stories_provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final block = StoriesProvider.of(context);
    block.fetchTopIds();

    return Scaffold(
      backgroundColor: Colors.orange,
      body: buildList(block),
    );
  }

  Widget buildList(StoriesBlock block) {
    return StreamBuilder(
      stream: block.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData){
          return Center(child: Text("No Data to show!!"));
        }

        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int index){
              return Text("hello ${snapshot.data[index]}");
            }
        );
      },
    );
  }

}
