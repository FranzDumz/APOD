import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:transparent_image/transparent_image.dart';

import 'ApodModel.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<ApodModel> futureAlbum;
  var isLoading = false;

  var queryParameters = {'api_key': 'bKWgMFO6n5ADhZfKCNVOn9fAJVIhXvDNX36q7X7o'};

  Future<ApodModel> getData() async {
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
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureAlbum = getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: FutureBuilder<ApodModel>(
        future: futureAlbum,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Stack(
                        children: <Widget>[
                          Center(child: CircularProgressIndicator()),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: snapshot.data.hdurl,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          snapshot.data.title,
                          style: TextStyle(
                              color: const Color(0xFF273A4D),
                              fontWeight: FontWeight.w900,
                              fontSize: 30),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        snapshot.data.explanation,
                        style: TextStyle(
                            color: const Color(0xFF273A4D),
                            fontWeight: FontWeight.w300,
                            fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data.copyright,
                          style: TextStyle(
                              color: const Color(0xFF273A4D),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          snapshot.data.date,
                          style: TextStyle(
                              color: const Color(0xFF273A4D),
                              fontWeight: FontWeight.w700,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    ));
  }
}
