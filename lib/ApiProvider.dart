import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';

import 'ApodModel.dart';

class ApiProvider {

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  http.Client client = http.Client();
  fetchPosts() async {
    String formattedDate = formatter.format(now);
    var queryParameters = {
      'api_key': 'bKWgMFO6n5ADhZfKCNVOn9fAJVIhXvDNX36q7X7o',
      'date': formattedDate
    };
    var response = await http.get(
      Uri.https("api.nasa.gov", "/planetary/apod", queryParameters),
    );
    ApodModel itemModel = ApodModel.fromJson(json.decode(response.body));
    return itemModel;
  }
}