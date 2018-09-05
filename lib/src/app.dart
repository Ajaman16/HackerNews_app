import 'package:flutter/material.dart';
import 'package:hackernews_app/src/screens/home.dart';
import 'package:hackernews_app/src/screens/news_details.dart';
import '../src/blocks/stories_provider.dart';
import '../src/blocks/comments_provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CommentsProvider(
      child: StoriesProvider(
        child: MaterialApp(
          title: "Hacker News",
          debugShowCheckedModeBanner: false,
          onGenerateRoute: routes,
        ),
      ),
    );

  }

  Route routes(RouteSettings settings){

    if(settings.name == '/'){
      return MaterialPageRoute(
          builder: (context){

            final storiesBlock = StoriesProvider.of(context);
            storiesBlock.fetchTopIds();
            return Home();
          }
      );
    }
    else
      {
        return MaterialPageRoute(
            builder: (context){
              final commentsBlock = CommentsProvider.of(context);
              final int itemId = int.parse(settings.name.replaceFirst("/", ""));

              commentsBlock.fetchItemsWithComments(itemId);

              return NewsDetails(itemId: itemId);
            }
        );
      }


  }
}
