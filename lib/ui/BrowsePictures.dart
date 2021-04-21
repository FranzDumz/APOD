import 'file:///C:/Users/Asus/FlutterProjects/apod/lib/ui/PictureDetails.dart';
import 'package:apod/reusables/Strings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

import 'package:apod/blocs/apod_bloc.dart';
import 'package:apod/models/ApodModel.dart';

class BrowsePictures extends StatefulWidget {
  @override
  _BrowsePicturesState createState() => _BrowsePicturesState();
}

class _BrowsePicturesState extends State<BrowsePictures> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: FutureBuilder<List<ApodModel>>(
          future: bloc.getDatabyRandom(),
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
              return Text(Strings.onError);
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    ));
  }
}
