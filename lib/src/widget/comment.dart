import 'package:flutter/material.dart';
import '../models/item_model.dart';
import 'dart:async';
import '../widget/loading_news_tile.dart';

class Comment extends StatelessWidget {

  final int itemId;
  final Map<int, Future<ItemModel>> itemMap;
  final int depth;

  Comment({this.itemId, this.itemMap, this.depth});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: itemMap[itemId],
        builder: (context, AsyncSnapshot<ItemModel> snapshot){
          if(!snapshot.hasData){
            return LoadingListTile();
          }

          final children = <Widget>[
            ListTile(
              title: Text("${snapshot.data.text}"),
              subtitle: snapshot.data.by == ""? Text("Deleted") :Text("${snapshot.data.by}"),
              contentPadding: EdgeInsets.only(
                right: 16.0,
                left: depth * 16.0
              ),
            ),
            Divider()
          ];


          snapshot.data.kids.forEach((kidId){
            children.add(Comment(itemId: kidId, itemMap: itemMap, depth: depth+1));
          });

          return Column(
            children: children,
          );
        }
    );
  }
}
