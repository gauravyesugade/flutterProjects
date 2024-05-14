import 'package:flutter/material.dart';
import 'dart:math';

import 'package:flutter/widgets.dart';

class ArrangeGame extends StatefulWidget {
  const ArrangeGame({super.key});
  @override
  State<StatefulWidget> createState() => _ArrangeGameState();
}

class _ArrangeGameState extends State {
  List noList = [];
  int a = 0;
  int b = 0;
  int c = 0;
  int d = 0;

  bool box1 = true;
  bool box2 = true;
  bool box3 = true;
  bool box4 = true;

  List imgList = [
    'images/mercury1.jfif',
    'images/venus1.jfif',
    'images/earth1.jfif',
    'images/mars1.jfif',
    'images/jupiter1.jfif',
    'images/saturn1.jfif',
    'images/uranus1.jfif',
    'images/neptune1.jpg',
  ];

  @override
  void initState() {
    super.initState();
    noList = generateUniqueRandomNumberList(4, 0, 7);
    a = noList[0];
    b = noList[1];
    c = noList[2];
    d = noList[3];
    print(noList);
    setState(() {});
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

  List choosenList = [];

  bool checkAnswer() {
    noList.sort();
    print("noList sorted = $noList");
    print("choosen list sorted = $choosenList");

    return noList.length == choosenList.length &&
        List.generate(
                noList.length, (index) => noList[index] == choosenList[index])
            .every((element) => element);
  }

  bool showAnswer = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(children: [
        Image.asset("images/gamesbg.png"),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
              ),
              const Text(
                "Rearrange the planets",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w300),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      choosenList.add(a);
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgList[a]),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      choosenList.add(b);
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgList[b]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      choosenList.add(c);
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgList[c]),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      choosenList.add(d);
                      setState(() {});
                    },
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(imgList[d]),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Center(
                child: Text(
                  "Arrange planets according to distance from sun",
                  style: TextStyle(color: Colors.white, fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 200,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: choosenList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        height: 88,
                        width: 88,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(imgList[choosenList[index]]),
                          ),
                        ),
                      );
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showAnswer = true;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text("Submit"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        noList = generateUniqueRandomNumberList(4, 0, 7);
                        a = noList[0];
                        b = noList[1];
                        c = noList[2];
                        d = noList[3];
                        choosenList = [];
                        showAnswer = false;
                        setState(() {});
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.4),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text("Reset"),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              showAnswer
                  ? Center(
                      child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0.4),
                              borderRadius: BorderRadius.circular(20)),
                          child: (checkAnswer())
                              ? Center(
                                  child: Container(
                                    child: const Text(
                                      "Correct Answer",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Container(
                                    child: const Text(
                                      "Wrong Answer",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                )),
                    )
                  : Container(),
            ],
          ),
        )
      ]),
    );
  }
}
