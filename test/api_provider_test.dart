import 'file:///C:/Users/Asus/FlutterProjects/apod/lib/resources/ApiProvider.dart';
import 'file:///C:/Users/Asus/FlutterProjects/apod/lib/models/ApodModel.dart';
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
    ApodModel item = await apiProvider.getDataByDates(formattedDate);
    expect(item.date, formattedDate);
  });

  test("test Random", () async {
    final apiProvider = ApiProvider();
    apiProvider.client = MockClient((request) async {
      final mapJson = {'date': formattedDate};

      return Response(json.encode(mapJson), 200);
    });
    List<ApodModel> item = await apiProvider.getRandomData();
    expect(item.length, 20);
  });


}