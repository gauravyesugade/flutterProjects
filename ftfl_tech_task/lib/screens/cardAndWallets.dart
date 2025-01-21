import 'package:flutter/material.dart';
import 'package:ftfl_tech_task/widgets/middleContainer.dart';

import '../widgets/cards.dart';

class CardAndWallets extends StatefulWidget {
  const CardAndWallets({super.key});

  @override
  State<CardAndWallets> createState() => _CardAndWalletsState();
}

class _CardAndWalletsState extends State<CardAndWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(250, 250, 255, 1),
      appBar: AppBar(
        title: const Text(
          "Cards & Wallets",
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipPath(
                    clipper: BottomRightClipper(),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 237, 238, 255),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        children: [
                          Image.asset("assets/images/card.png"),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 40,
                              ),
                              const Text(
                                "Card Status : ",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Text(
                                "Inactive",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 40,
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color.fromARGB(255, 227, 229, 254)),
                      child: const Text(
                        "Guide",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 23, 28, 84),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              activateLifelineCard(context),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Wallet",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              card1(),
              const SizedBox(
                height: 15,
              ),
              //2
              card2(),
              const SizedBox(
                height: 10,
              ),
              card3(),
            ],
          ),
        ),
      ),
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
