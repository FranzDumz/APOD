import 'dart:async';

import 'package:apod/models/ApodModel.dart';
import 'package:apod/resources/ApiProvider.dart';

class Repository {


  final apodApiProvider = ApiProvider();

  Future<ApodModel> fetchData(String date) => apodApiProvider.getData(date);
}

