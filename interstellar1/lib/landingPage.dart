import 'package:flutter/material.dart';
import 'galaxies.dart';
import 'games.dart';
import 'planets.dart';
import 'stars.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});
  @override
  State createState() => _LandingPageState();
}

class _LandingPageState extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset(
            "images/home1.png",
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 60,
                  ),
                  const Text(
                    "Welcome Onboard,",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    "Garry",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  // TextFormField(
                  //   //controller: usernameController,
                  //   cursorColor: Colors.white,
                  //   style: const TextStyle(color: Colors.white),
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     fillColor: const Color.fromRGBO(255, 255, 255, 0.2),
                  //     hintText: "Search for your favorite planet...",
                  //     suffixIcon: const Icon(
                  //       Icons.search,
                  //       color: Colors.white,
                  //       size: 30,
                  //     ),
                  //     hintStyle: const TextStyle(
                  //       color: Color.fromRGBO(255, 255, 255, 0.8),
                  //     ),
                  //     enabledBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //     focusedBorder: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(10.0),
                  //     ),
                  //   ),
                  //   validator: (value) {
                  //     if (value == null || value.isEmpty) {
                  //       return "Please enter username";
                  //     } else {
                  //       return null;
                  //     }
                  //   },
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    "Start a new Journey",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w300),
                  ),
                  const Text(
                    "Lets explore our space...!!!",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Planets()),
                              );
                            },
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Color.fromRGBO(255, 255, 255, 0.45),
                                  )
                                ],
                                image: const DecorationImage(
                                    image: AssetImage("images/planet1.webp"),
                                    fit: BoxFit.fill),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Planets",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Stars()),
                              );
                            },
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Color.fromRGBO(255, 255, 255, 0.45),
                                  )
                                ],
                                image: const DecorationImage(
                                    image: AssetImage("images/stars.webp"),
                                    fit: BoxFit.cover),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Stars",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Galaxy()),
                              );
                            },
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              padding: const EdgeInsets.all(20),
                              margin: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Color.fromRGBO(255, 255, 255, 0.45),
                                  )
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "images/galaxy.jfif",
                                    ),
                                    fit: BoxFit.fill),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Galxies",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Games()),
                              );
                            },
                            child: Container(
                              height: 140,
                              width: double.infinity,
                              margin: const EdgeInsets.all(5),
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    offset: Offset(1, 1),
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    color: Color.fromRGBO(255, 255, 255, 0.45),
                                  )
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                      "images/quiz.jpeg",
                                    ),
                                    fit: BoxFit.fill),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: const Text(
                                "Games",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
