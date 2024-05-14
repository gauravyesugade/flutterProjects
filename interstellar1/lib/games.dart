import 'package:flutter/material.dart';
import 'dart:math';

class Games extends StatefulWidget {
  const Games({super.key});
  @override
  State<StatefulWidget> createState() => _GamesState();
}

class _GamesState extends State {
  void initState() {
    super.initState();
    print(generateUniqueRandomNumberList(4, 1, 10));
  }

  List<int> generateUniqueRandomNumberList(int length, int min, int max) {
    if (length > max - min + 1) {
      throw ArgumentError('Length should not exceed the range of numbers');
    }

    Random random = Random();
    Set<int> uniqueNumbers = Set<int>();

    while (uniqueNumbers.length < length) {
      uniqueNumbers.add(min + random.nextInt(max - min + 1));
    }

    return uniqueNumbers.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Image.asset("images/gamesbg.png"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 80,
                ),
                const Text(
                  "Guess The....",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.w300),
                ),
                const Text(
                  "Space",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontWeight: FontWeight.w300),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/mars.png"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "Guess the Planet in above image",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w300),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(255, 255, 255, 0.3),
                    hintText: "Guess",
                    suffixIcon: const Icon(
                      Icons.question_mark,
                      color: Colors.white,
                    ),
                    hintStyle: const TextStyle(
                      color: Color.fromRGBO(255, 255, 255, 0.8),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
