import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'overviewScreen.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({super.key});

  @override
  State createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      // overlap karnya sathi ahe
      children: [
        Image.asset(
          'images/src1.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 55),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                  width: double.infinity,
                ),
                const Text("Virtual",
                    style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(255, 255, 255, 1))),
                const Text("Galaxy",
                    style: TextStyle(
                        fontSize: 77,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1))),
                const Text("Explorer",
                    style: TextStyle(
                        fontSize: 77,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1))),
                const Text(
                    "We will learn all of the scientific disciplines that involve.",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(255, 255, 255, 1))),
                Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const OverviewScreen()));
                  },
                  child: Container(
                    width: 329,
                    height: 75,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color.fromRGBO(255, 255, 255, 1)),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Start Learning  ",
                            style: GoogleFonts.poppins(
                                fontSize: 21,
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 0, 0, 0))),
                        Image.asset("images/arrow.png")
                      ],
                    )),
                  ),
                )
              ],
            )),
      ],
    ));
  }
}
