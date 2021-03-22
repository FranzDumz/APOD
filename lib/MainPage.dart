import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset('images/staticimage.jpg'),
                SizedBox(
                  height: 30,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'From Auriga to Orion',
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
                  'Whats up in the sky from Auriga to Orion? Many of the famous stars and nebulas in this region were captured on 34 separate images, taking over 430 hours of exposure, and digitally combined to reveal the featured image. Starting on the far upper left, toward the constellation of Auriga (the Chariot driver), is the picturesque Flaming Star Nebula (IC 405).  Continuing down along the bright arc of our Milky Way Galaxy, from left to right crossing the constellations of the Twins and the Bull, notable appearing nebulas include the Tadpole, Simeis 147, Monkey Head, Jellyfish, Cone and Rosette nebulas.  In the upper right quadrant of the image, toward the constellation of Orion (the hunter), you can see Sh2-264, the half-circle of Barnards Loop, and the Horsehead and Orion nebulas. Famous stars in and around Orion include, from left to right, orange Betelgeuse (just right of the image center), blue Bellatrix (just above it), the Orion belt stars of Mintaka, Alnilam, and Alnitak, while bright Rigel appears on the far upper right. This stretch of sky wont be remaining up in the night very long -- it will be setting continually earlier in the evening as mid-year approaches.',
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
                       "Alistair Symon",
                       style: TextStyle(
                        color: const Color(0xFF273A4D),
                        fontWeight: FontWeight.w700,
                        fontSize: 20),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "2021-03-22",
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
      ),
    );
  }
}
