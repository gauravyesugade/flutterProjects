import 'package:flutter/material.dart';
import 'dart:math';

class ImageOrderingScreen extends StatefulWidget {
  const ImageOrderingScreen({super.key});
  @override
  _ImageOrderingScreenState createState() => _ImageOrderingScreenState();
}

class _ImageOrderingScreenState extends State<ImageOrderingScreen> {
  List<String> imageUrls = [
    'images/mercury1.jfif',
    'images/venus1.jfif',
    'images/earth1.jfif',
    'images/mars1.jfif',
    'images/jupiter1.jfif',
    'images/saturn1.jfif',
    'images/uranus1.jfif',
    'images/neptune1.jpg',
  ];

  List<int> randomIndexes = [];

  @override
  void initState() {
    super.initState();
    generateRandomIndexes();
  }

  void generateRandomIndexes() {
    Random random = Random();
    randomIndexes.clear();
    while (randomIndexes.length < 4) {
      int randomIndex = random.nextInt(imageUrls.length);
      if (!randomIndexes.contains(randomIndex)) {
        randomIndexes.add(randomIndex);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Ordering Game'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        content: Image.asset(imageUrls[randomIndexes[index]]),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Close'),
                          ),
                        ],
                      ),
                    );
                  },
                  child: Image.asset(imageUrls[randomIndexes[index]]),
                );
              }),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(4, (index) {
                return DragTarget<int>(
                  builder: (BuildContext context, List<int?> candidateData,
                      List<dynamic> rejectedData) {
                    return Container(
                      width: 60,
                      height: 60,
                      color: Colors.grey[200],
                      child: Center(
                        child: Text(
                          (index + 1).toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    );
                  },
                  onAccept: (int data) {
                    if (data == randomIndexes[index]) {
                      setState(() {
                        randomIndexes[index] = -1;
                      });
                    }
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
