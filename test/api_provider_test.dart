import 'package:apod/ApiProvider.dart';
import 'package:apod/ApodModel.dart';
import 'package:apod/MainPage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'dart:convert';

import 'package:intl/intl.dart';

void main() {
  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  String formattedDate = formatter.format(now);
  test("test date", () async {
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = {'date': formattedDate};

      return Response(json.encode(mapJson), 200);
    });
    ApodModel item = await apiProvider.fetchPosts();
    expect(item.date, formattedDate);
  });

  test("test copyright", () async {
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = {'copyright': "Robert Gendler"};

      return Response(json.encode(mapJson), 200);
    });
    ApodModel item = await apiProvider.fetchPosts();
    expect(item.copyright, "Robert Gendler");
  });


}