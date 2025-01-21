import 'package:flutter/material.dart';

class CardAndWallets extends StatefulWidget {
  const CardAndWallets({super.key});

  @override
  State<CardAndWallets> createState() => _CardAndWalletsState();
}

class _CardAndWalletsState extends State<CardAndWallets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cards & Wallets"),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            myContainer(BuildContext),
          ],
        ),
      ),
    );
  }

  Widget myContainer(buildContext) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Active your LifelineCard",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Text(
                    "₹ 3499/- Life Time",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(192, 34, 206, 1)),
                  ),
                  const Text(
                    "₹ 9999/Year",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(207, 85, 58, 1),
                    ),
                  ),
                  const Text(
                    "Offer Ends Soon!",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10),
                    padding: const EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: const Color.fromRGBO(67, 9, 117, 1),
                    ),
                    child: const Text(
                      "Activate Now",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(208, 194, 209, 1)),
                    ),
                  )
                ],
              ),
              //Image
              // Image.asset("")
            ],
          ),
          const Divider(),
          const Text(
            "Our Features",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      "Udhar Limit: ₹74425",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(143, 143, 143, 1)),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 6),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  children: [
                    Text(
                      "CP EMI Limit: ₹74425",
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(143, 143, 143, 1)),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //udhar column
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(126, 126, 126, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/card.png",
                      height: 20,
                      width: 30,
                    ),
                  ),
                  const Text(
                    "Udhar",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //CP EMI
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(126, 126, 126, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/card.png",
                      height: 20,
                      width: 30,
                    ),
                  ),
                  const Text(
                    "CP EMI",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              //Bussiness Funds
              Column(
                children: [
                  Container(
                    height: 70,
                    width: 120,
                    decoration: BoxDecoration(
                      color: const Color.fromRGBO(126, 126, 126, 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    alignment: Alignment.center,
                    child: Image.asset(
                      "assets/images/card.png",
                      height: 20,
                      width: 30,
                    ),
                  ),
                  const Text(
                    "Bussiness Funds",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
