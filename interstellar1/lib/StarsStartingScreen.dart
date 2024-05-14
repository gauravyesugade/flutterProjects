import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'PlanetStartingcreen.dart';

class StarsStartingScreen extends StatefulWidget {
  const StarsStartingScreen({super.key});

  @override
  State createState() => _StarsStartingScreenState();
}

class _StarsStartingScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Image.asset(
        'images/src4.png',
        fit: BoxFit.fill,
        width: double.infinity,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
        child: Column(children: [
          Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 0,
                vertical: 0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Text(
                            "Learn about",
                            style: GoogleFonts.poppins(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                          Text(
                            "Stars",
                            style: GoogleFonts.poppins(
                              fontSize: 63,
                              fontWeight: FontWeight.w600,
                              color: const Color.fromRGBO(255, 255, 255, 1),
                            ),
                          ),
                        ],
                      )
                    ])
                  ])),
          Spacer(),
          Container(
            height: 196,
            width: 338,
            padding: const EdgeInsets.only(right: 15, left: 15),
            child: Text(
              "Stellar Discoveries: Embark on an illuminating voyage to uncover the secrets of stars. From the blazing birth of stars to the enchanting constellations that adorn our night sky",
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w500,
                color: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          Center(
            child: Container(
              height: 75,
              width: 75,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlanetStartingScreen()));
                },
                child: Image.asset("images/arrow.png"),
                backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
              ),
            ),
          )
        ]),
      )
    ]));
  }
}
