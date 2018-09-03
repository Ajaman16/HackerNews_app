import 'dart:async';

import 'package:rxdart/rxdart.dart';
import '../resources/repository.dart';
import '../models/item_model.dart';

class StoriesBlock{

  final _repository = Repository();
  final _topIds = PublishSubject<List<int>>();
  final _itemsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();
  final _itemsFetcher = PublishSubject<int>();

  //Getters to Streams
  Observable<List<int>> get topIds => _topIds.stream;
  Observable<Map<int, Future<ItemModel>>> get items => _itemsOutput.stream;

  //Getters to Sinks
  Function(int) get fetchItem => _itemsFetcher.sink.add;

  StoriesBlock(){
    _itemsFetcher.stream.transform(_ItemsTransformer()).pipe(_itemsOutput);
  }

  fetchTopIds()async{
    final ids = await _repository.fetchTopIds();
    _topIds.sink.add(ids);
  }

  _ItemsTransformer(){
    return ScanStreamTransformer(
        (Map<int, Future<ItemModel>> cache, int id, index){
          print(index);
          cache[id] = _repository.fetchItem(id);
          return cache;
        },
      <int, Future<ItemModel>>{}
    );
  }

  Future<int> clearCache(){
    return _repository.clearCache();
  }

  dispose(){
    _topIds.close();
    _itemsOutput.close();
    _itemsFetcher.close();
  }

}