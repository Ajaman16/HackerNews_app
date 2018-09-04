import 'comments_block.dart';
export 'comments_block.dart';
import 'package:flutter/material.dart';

class CommentsProvider extends InheritedWidget{

  final CommentsBlock block;


  CommentsProvider({Key key, Widget child}):
      block = CommentsBlock(),
      super(key:key, child:child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return true;
  }

  static CommentsBlock of(BuildContext context){
    return (context.inheritFromWidgetOfExactType(CommentsProvider) as CommentsProvider).block;
  }


}