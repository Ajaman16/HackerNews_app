import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hackernews_app/src/widget/loading_news_tile.dart';
import '../blocks/stories_provider.dart';
import '../models/item_model.dart';

class NewsListTile extends StatelessWidget {

  final int itemId;

  NewsListTile({this.itemId});

  @override
  Widget build(BuildContext context) {
    final block = StoriesProvider.of(context);

    return StreamBuilder(
      stream: block.items,
      builder: (context, AsyncSnapshot<Map<int, Future<ItemModel>>> snapshot){
         if(!snapshot.hasData)
           {
             return LoadingListTile();
           }

         return FutureBuilder(
           future: snapshot.data[itemId],
           builder: (context, AsyncSnapshot<ItemModel> itemSnapshot){
              if(!itemSnapshot.hasData)
                {
                  return LoadingListTile();
                }

              return buildListTile(itemSnapshot.data);
           }
         );
      }
    );
  }

  Widget buildListTile(ItemModel data) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(data.title),
          subtitle: Text("${data.score} votes"),
          trailing: Column(
            children: <Widget>[
              Icon(Icons.comment),
              Text("${data.descendants}")
            ],
          ),
        ),
        Divider(
          height: 8.0,
        )
      ],
    );

  }
}
