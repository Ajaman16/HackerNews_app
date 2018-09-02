import 'stories_block.dart';
import 'package:flutter/material.dart';

class StoriesProvider extends InheritedWidget{

   final StoriesBlock block;

   StoriesProvider({Key key, Widget child}):
       block = StoriesBlock(),
       super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static StoriesBlock of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(StoriesProvider) as StoriesProvider).block;
  }

}