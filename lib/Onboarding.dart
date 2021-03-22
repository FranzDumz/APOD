import 'package:flutter/material.dart';
import 'MainPage.dart';

class Onboarding extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        // backgroundColor: const Color(0xFF210d1f),
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(children: [
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(
                'images/nasa_logo.png',
                width: 150.0,
                height: 150.0,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'APOD',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 70),
                    ),
                    TextSpan(
                      text: '\nAstronomy Picture \nof the Day.',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MainPage()),
                          );
                        },
                        child: Text("View"),
                      ),
                    ))),
          ),
        ])));
  }
}
