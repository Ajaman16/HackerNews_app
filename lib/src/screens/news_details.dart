import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackernews_app/src/widget/comment.dart';
import '../models/item_model.dart';
import '../blocks/comments_provider.dart';

class NewsDetails extends StatelessWidget {

  final int itemId;

  NewsDetails({this.itemId});

  @override
  Widget build(BuildContext context) {

    final block = CommentsProvider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Comments"),
      ),
      body: buildBody(block),
    );
  }

  Widget buildBody(CommentsBlock block) {
    return StreamBuilder(
        stream: block.itemWithComments,
        builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
            if(!snapshot.hasData){
              return Text("Loading!!");
            }

            final itemFuture = snapshot.data[itemId];

            return FutureBuilder(
              future: itemFuture,
              builder: (context, AsyncSnapshot<ItemModel> itemSnapshot){
                if(!itemSnapshot.hasData){
                  return Text("Loading!!");
                }

                return buildList(itemSnapshot.data, snapshot.data);
              },
            );
        }
    );
  }

  Widget buildList(ItemModel item, Map<int, Future<ItemModel>> itemMap) {

    var children = <Widget>[];
    children.add(buildTitle(item));

    final commentList = item.kids.map((kidId){
      return Comment(itemId: kidId, itemMap: itemMap, depth: 1,);
    }).toList();

    children.addAll(commentList);

    return ListView(
      children: children
    );

  }

  Widget buildTitle(ItemModel data) {
    return Container(
      margin: EdgeInsets.all(10.0),
      alignment: Alignment.topCenter,
      child: Text(
        "${data.title}",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

}
