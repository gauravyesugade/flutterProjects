import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'LoginOptionScreen.dart';

class PlanetStartingScreen extends StatefulWidget {
  const PlanetStartingScreen({super.key});

  @override
  State createState() => _PlanetStartingScreenState();
}

class _PlanetStartingScreenState extends State {
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
            padding: const EdgeInsets.symmetric(
              horizontal: 30,
              vertical: 30,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0,
                    vertical: 0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 30),
                              Text(
                                "Learn about",
                                style: GoogleFonts.poppins(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w500,
                                  color: const Color.fromRGBO(255, 255, 255, 1),
                                ),
                              ),
                              Text(
                                "Planets",
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
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Embark on a celestial journey to explore the captivating realms of planets. From the fiery surface of Venus to the icy mysteries of Neptune, this section is your portal to unravel the diverse landscapes and enigmas",
                    style: GoogleFonts.poppins(
                      fontSize: 19,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
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
                                    const LoginOptionScreen()));
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
