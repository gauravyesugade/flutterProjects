import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic starDatabase;

class Stars extends StatefulWidget {
  const Stars({super.key});
  @override
  State createState() => _StarsState();
}

class StarsInfo {
  String starName;
  String starTitle;
  String starInformation;
  String image;

  StarsInfo(
      {required this.starName,
      required this.starTitle,
      required this.starInformation,
      required this.image});
  Map<String, dynamic> starMap() {
    return {
      'starName': starName,
      'starTitle': starTitle,
      'starInformation': starInformation,
      'image': image
    };
  }

  // @override
  // String toString() {
  //   return "{planetName: $starName, planetTitle: $starTitle, planetInformation: $starInformation}";
  // }
}

class _StarsState extends State {
  List starList = [];
  @override
  void initState() {
    super.initState();
    createDB();
  }

  Future createDB() async {
    starDatabase = await openDatabase(
      join(await getDatabasesPath(), 'starsDB.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE starsTable(
            starName TEXT PRIMARY KEY,
            starTitle TEXT,
            starInformation TEXT,
            image Text
          )
      ''');
      },
    );
    StarsInfo obj = StarsInfo(
      starName: "Sigma Scorpii",
      starTitle: "Stellar Data for Sigma Scorpii",
      starInformation:
          "Sigma Scorpii, also known as Al Niyat, is a binary star system located in the constellation Scorpius. It is one of the stars that form the prominent 'stinger' of the scorpion in Scorpius. Sigma Scorpii consists of two main components: Sigma Scorpii A and Sigma Scorpii B. Sigma Scorpii A is a blue-white main sequence star, while Sigma Scorpii B is a fainter companion star. The system is approximately 730 light-years away from Earth. Al Niyat has a combined apparent magnitude of around 2.9, making it visible to the naked eye under good viewing conditions. This star system is of interest to astronomers studying binary stars and stellar evolution.",
      image: "images/sigma.jpg",
    );

    insertDB(obj);
    starList = await getstarDB();
    setState(() {});
  }

  Future insertDB(StarsInfo obj) async {
    final localDB = await starDatabase;
    await localDB.insert(
      'starsTable',
      obj.starMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getstarDB() async {
    final localDB = await starDatabase;
    List starsfromDB = await localDB.query('starsTable');
    return starsfromDB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/starsbg.jpg",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 140,
                  ),
                  const Text(
                    "Explore Stars",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                        fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: starList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 130,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Color.fromRGBO(255, 255, 255, 0.45),
                                )
                              ],
                              image: DecorationImage(
                                  image: AssetImage(starList[index]['image']),
                                  fit: BoxFit.cover),
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              starList[index]['starName'],
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontWeight: FontWeight.w500),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
