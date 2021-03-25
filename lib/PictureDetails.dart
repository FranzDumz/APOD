import 'package:cached_network_image/cached_network_image.dart';
import "package:flutter/material.dart";
import "ApodModel.dart";

class PictureDetails extends StatelessWidget {
  final ApodModel _user;

  PictureDetails(this._user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              /// This is the important part, we need [Hero] widget with unique tag but same as Hero's tag in [User] widget.
              child: Hero(
                tag: "avatar_" + _user.date,
                child: CachedNetworkImage(
                  imageUrl: _user.hdurl ?? "error",
                  placeholder: (context, url) => LinearProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      _user.title,
                      style: TextStyle(
                          color: const Color(0xFF273A4D),
                          fontWeight: FontWeight.w900,
                          fontSize: 30),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _user.copyright ?? 'Unknown',
                      style: TextStyle(
                          color: const Color(0xFF273A4D),
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _user.date,
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
                    _user.explanation,
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
          ]),
        ),
      ),
    );
  }
}
