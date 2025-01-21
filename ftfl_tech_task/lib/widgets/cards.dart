import 'package:flutter/material.dart';

class card1 extends StatelessWidget {
  const card1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomRightClipper(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 238, 255),
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/IMG_7862.png"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lifeline Card Wallet",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("Upcomming EMI/udhar")
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          "4356",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("4356")
                      ],
                    ),
                    const SizedBox(
                      width: 10,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Withdraw",
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 63, 148),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Transfer",
                      style: TextStyle(
                        color: Color.fromARGB(255, 77, 63, 148),
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(),
                    const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            height: 40,
            width: 110,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 227, 229, 254)),
            child: const Text(
              "More",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 23, 28, 84),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class card3 extends StatelessWidget {
  const card3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomRightClipper(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 238, 255),
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                          "assets/images/IMG_7863.png"), // Set image as background
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Cashback Coin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Add Credit Coin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          "4356",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "11th Sep 2023 To 11 Oct 2023",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            height: 40,
            width: 110,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 227, 229, 254)),
            child: const Text(
              "More",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 23, 28, 84),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class card2 extends StatelessWidget {
  const card2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipPath(
          clipper: BottomRightClipper(),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 237, 238, 255),
              // border: Border.all(width: 1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage("assets/images/IMG_7863.png"),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Lifeline Coin",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Lifeline Magic Coin",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 52, 52, 116),
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        const Text(
                          "4356",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "600",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 52, 52, 116),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "11th Sep 2023 To 11 Oct 2023",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 5,
          right: 5,
          child: Container(
            height: 40,
            width: 110,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 227, 229, 254)),
            child: const Text(
              "More",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 23, 28, 84),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BottomRightClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    double cornerRadius = 15.0;
    double cutOutWidth = 120.0;
    double cutOutHeight = 50.0;

    Path path = Path();

    path.moveTo(cornerRadius, 0);
    path.quadraticBezierTo(0, 0, 0, cornerRadius);

    path.lineTo(0, size.height - cornerRadius);
    path.quadraticBezierTo(0, size.height, cornerRadius, size.height);

    path.lineTo(size.width - cutOutWidth - cornerRadius, size.height);
    path.quadraticBezierTo(size.width - cutOutWidth, size.height,
        size.width - cutOutWidth, size.height - cornerRadius);

    path.lineTo(
        size.width - cutOutWidth, size.height - cutOutHeight + cornerRadius);
    path.quadraticBezierTo(size.width - cutOutWidth, size.height - cutOutHeight,
        size.width - cutOutWidth + cornerRadius, size.height - cutOutHeight);

    path.lineTo(size.width - cornerRadius, size.height - cutOutHeight);
    path.quadraticBezierTo(size.width, size.height - cutOutHeight, size.width,
        size.height - cutOutHeight - cornerRadius);

    path.lineTo(size.width, cornerRadius);
    path.quadraticBezierTo(size.width, 0, size.width - cornerRadius, 0);

    path.lineTo(cornerRadius, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
