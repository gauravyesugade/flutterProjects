import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'StarsStartingScreen.dart';

class GalaxyScreen extends StatefulWidget {
  const GalaxyScreen({super.key});

  @override
  State createState() => _GalaxyScreenState();
}

class _GalaxyScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'images/src3.png',
            fit: BoxFit.fill,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 45),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 15),
                              Text(
                                "Learn about",
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "Galaxies",
                                style: GoogleFonts.poppins(
                                  fontSize: 63,
                                  fontWeight: FontWeight.w600,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Text(
                    "Explore the Marvels of Galaxies: Dive into a cosmic journey to learn about the awe-inspiring galaxies that populate our universe.",
                    textAlign: TextAlign.left,
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
                                builder: (context) =>
                                    const StarsStartingScreen()));
                      },
                      child: Image.asset("images/arrow.png"),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
