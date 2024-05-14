import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginOptionScreen.dart';
import 'GalaxyScreen.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // overlap karnya sathi ahe
      children: [
        Image.asset(
          'images/src2.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LoginOptionScreen()));
                      },
                      child: Container(
                          height: 35,
                          width: 80,
                          margin: const EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(255, 255, 255, 0.3)),
                          child: const Center(child: Text("Skip"))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 40,
                  width: double.infinity,
                ),
                Text("Insights",
                    style: GoogleFonts.poppins(
                        fontSize: 63,
                        fontWeight: FontWeight.w600,
                        color: const Color.fromRGBO(255, 255, 255, 1))),
                Spacer(),
                Text(
                    "Embark on an interstellar voyage like  never before. Explore distant galaxies,  uncover cosmic secrets, and witness the majesty of the universe. Your cosmic  adventure begins here.",
                    style: GoogleFonts.poppins(
                        fontSize: 19,
                        fontWeight: FontWeight.w500,
                        color: const Color.fromRGBO(255, 255, 255, 1))),
                const SizedBox(
                  height: 15,
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
                                builder: (context) => const GalaxyScreen()));
                      },
                      child: Image.asset("images/arrow.png"),
                      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
                    ),
                  ),
                )
              ],
            )),
      ],
    ));
  }
}
