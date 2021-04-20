import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/ApodModel.dart';

class ApiProvider {
  Future<ApodModel> futureAlbum;
  var isLoading = false;

  Future<ApodModel> getDataByDates(String date) async {
    var queryParameters = {
      'api_key': 'bKWgMFO6n5ADhZfKCNVOn9fAJVIhXvDNX36q7X7o',
      'date': date
    };
    var response = await http.get(
      Uri.https("api.nasa.gov", "/planetary/apod", queryParameters),
    );

    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      return ApodModel.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Something Went Wrong');
    }
  }

  Stream<ApodModel> getnewData(String date) async* {
    await Future.delayed(Duration(seconds: 1));
    yield await getDataByDates(date);
  }


  Future<List<ApodModel>> getRandomData() async {
    var queryParameters = {
      'api_key': 'bKWgMFO6n5ADhZfKCNVOn9fAJVIhXvDNX36q7X7o',
      'count': '20'
    };
    var response = await http.get(
      Uri.https("api.nasa.gov", "/planetary/apod", queryParameters),
    );

    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      List<ApodModel> list = (json.decode(response.body) as List)
          .map((data) => ApodModel.fromJson(data))
          .toList();
      return list;

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Something Went Wrong');
    }
  }
}
