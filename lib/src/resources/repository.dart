import 'dart:async';
import 'news_api_provider.dart';
import 'news_db_provider.dart';
import '../models/item_model.dart';

class Repository{

  List<Source> sources = [
    newsDbProvider,
    NewsApiProvider()
  ];

  List<Cache> caches = [
    newsDbProvider
  ];

  Future<List<int>> fetchTopIds(){
    return sources[1].fetchTopIds();
  }

  Future<ItemModel> fetchItem(int id) async{

   /* var item = await newsDbProvider.fetchItem(id);

    if(item != null){
      return item;
    }

    item = await newsApiProvider.fetchItem(id);
    newsDbProvider.addItem(item);
    return item;*/

   ItemModel item;
   Source source;

   for(source in sources){
     item = await source.fetchItem(id);
     if(item != null){
       break;
     }
   }

   for(var cache in caches){
     cache.addItem(item);
   }

   return item;

  }


}

abstract class Source{
  Future<List<int>> fetchTopIds();
  Future<ItemModel> fetchItem(int id);
}

abstract class Cache{
  Future<int> addItem(ItemModel item);
}