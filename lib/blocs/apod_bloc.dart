import 'package:apod/models/ApodModel.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class ApodBloc {


  final _repository = Repository();
  final apodFetcher = PublishSubject<ApodModel>();

  Stream<ApodModel> get fetchData => apodFetcher.stream;

  getData(String date) async {
    ApodModel itemModel = await _repository.fetchData(date);
    apodFetcher.sink.add(itemModel);
  }

  dispose() {
    apodFetcher.close();
  }
}

final bloc = ApodBloc();