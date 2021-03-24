import 'dart:convert';

import 'package:apod/BrowsePictures.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'ApodModel.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  Future<ApodModel> futureAlbum;
  var isLoading = false;

  var now = new DateTime.now();
  var formatter = new DateFormat('yyyy-MM-dd');
  DateTime selectedDate = DateTime.now();
  String formattedDate;

  Future<ApodModel> getData(String date) async {
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
    yield await getData(date);
  }

  @override
  void initState() {
    super.initState();
    String formattedDate = formatter.format(now);
    futureAlbum = getData(formattedDate);
  }

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime(1995, 06, 16),
        lastDate: DateTime(now.year, now.month, now.day));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        formattedDate = formatter.format(selectedDate);
        getnewData(formattedDate);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          automaticallyImplyLeading: false,
          title: Text(
            "APOD",
            style: TextStyle(color: Colors.black),
          ),
          elevation: 10,
          backgroundColor: Colors.white,
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.calendar_today_outlined), // The "-" icon
                onPressed: () => {_selectDate(context)},
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(Icons.list_alt), // The "-" icon
                onPressed: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BrowsePictures()),
                  )
                },
              ),
            )
          ],
        ),
        body: Center(
          child: StreamBuilder<ApodModel>(
            stream: getnewData(formattedDate),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData) {
                return SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Stack(
                            children: <Widget>[
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data.hdurl,
                                    placeholder: (context, url) =>
                                        LinearProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
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
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data.copyright ?? 'Unknown',
                              style: TextStyle(
                                  color: const Color(0xFF273A4D),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              snapshot.data.date,
                              style: TextStyle(
                                  color: const Color(0xFF273A4D),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
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
