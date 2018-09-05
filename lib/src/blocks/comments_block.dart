import 'package:rxdart/rxdart.dart';
import '../models/item_model.dart';
import '../resources/repository.dart';
import 'dart:async';

class CommentsBlock{

  final _repository = Repository();
  final _commentsFetcher = PublishSubject<int>();
  final _commentsOutput = BehaviorSubject<Map<int, Future<ItemModel>>>();

  //Streams
  Observable<Map<int, Future<ItemModel>>> get itemWithComments => _commentsOutput.stream;

  //Sink
  Function(int) get fetchItemsWithComments => _commentsFetcher.sink.add;

  CommentsBlock(){
    _commentsFetcher.stream.transform(_commentsTransformer()).pipe(_commentsOutput);
  }

  _commentsTransformer(){
    return ScanStreamTransformer<int, Map<int, Future<ItemModel>>>(
      (cache, int id, index){
        print(index);
        cache[id] = _repository.fetchItem(id);
        cache[id].then((ItemModel item){
          item.kids.forEach((kidId) => fetchItemsWithComments(kidId));
        });
        return cache;
      },
      <int, Future<ItemModel>> {}
    );
  }

  dispose(){
    _commentsFetcher.close();
    _commentsOutput.close();
  }
}