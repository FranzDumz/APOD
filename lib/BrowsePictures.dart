import 'package:apod/MainPage.dart';
import 'package:apod/PictureDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ApodModel.dart';

class BrowsePictures extends StatefulWidget {
  @override
  _BrowsePicturesState createState() => _BrowsePicturesState();
}

class _BrowsePicturesState extends State<BrowsePictures> {
  Future<List<ApodModel>> futureAlbum;
  var isLoading = false;

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  String formattedDate;

  Future<List<ApodModel>> getData() async {
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

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final title = 'Browse';

    return Scaffold(
        body: SafeArea(
      child: Center(
        child: FutureBuilder<List<ApodModel>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder(
                  itemCount: snapshot.data.length,
                  cacheExtent: 9999,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  PictureDetails(snapshot.data[index]))),
                      child: Stack(
                        children: <Widget>[
                          Center(
                            child: Hero(
                              tag: "avatar_" + snapshot.data[index].date,
                              child: CachedNetworkImage(
                                  imageUrl:
                                      snapshot.data[index].hdurl ?? "error",
                                  errorWidget: (context, url, error) =>
                                      SizedBox.shrink()),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text("Error");
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
