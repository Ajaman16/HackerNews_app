import 'package:flutter/material.dart';
import 'package:hackernews_app/src/blocks/stories_block.dart';
import 'package:hackernews_app/src/widget/news_list_tile.dart';
import 'package:hackernews_app/src/widget/refresh.dart';
import 'dart:async';
import '../blocks/stories_provider.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final block = StoriesProvider.of(context);
    //block.fetchTopIds();

    return Scaffold(
      appBar: AppBar(
        title: Text("Top News"),
      ),
      backgroundColor: Colors.white,
      body: buildList(block),
    );
  }

  Widget buildList(StoriesBlock block) {
    return StreamBuilder(
      stream: block.topIds,
      builder: (context, AsyncSnapshot<List<int>> snapshot){
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }

        return Refresh(
          child: ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (context, int index){
                block.fetchItem(snapshot.data[index]);
                return NewsListTile(itemId: snapshot.data[index]);
              }
          ),
        );
      },
    );
  }

}
