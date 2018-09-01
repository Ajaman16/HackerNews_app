import 'dart:async';
import 'repository.dart';
import 'package:hackernews_app/src/models/item_model.dart';
import 'package:http/http.dart' show Client;
import 'dart:convert';

class NewsApiProvider implements Source{

  final client = Client();
  final baseURL = " https://hacker-news.firebaseio.com/v0";
  
  Future<List<int>> fetchTopIds() async{
    final response = await client.get("$baseURL/topstories.json");
    final ids = json.decode(response.body);
    return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async{
    final response = await client.get("$baseURL/$id.json");
    final parsedJSON = json.decode(response.body);
    return ItemModel.fromJSON(parsedJSON);
  }
}