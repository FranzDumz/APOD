import 'package:apod/models/ApodModel.dart';

import '../resources/repository.dart';
import 'package:rxdart/rxdart.dart';


class ApodBloc {


  final repository = Repository();
  final apodFetcher = PublishSubject<ApodModel>();

  Stream<ApodModel> get fetchDataByDate => apodFetcher.stream;

  

  getDatabyDate(String date) async {
    ApodModel itemModel = await repository.fetchData(date);
    apodFetcher.sink.add(itemModel);
  }


  Future<List<ApodModel>> getDatabyRandom() async {
    List<ApodModel> itemModel2 = await repository.fetchRandomData();
    return itemModel2;
  }



  dispose() {
    apodFetcher.close();
  }
}

final bloc = ApodBloc();