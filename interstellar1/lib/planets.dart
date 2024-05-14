import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic planetDatabase;

class Planets extends StatefulWidget {
  const Planets({super.key});
  @override
  State createState() => _Planets();
}

class PlanetsInfo {
  String planetName;
  String planetTitle;
  String planetInformation;
  String image;

  PlanetsInfo(
      {required this.planetName,
      required this.planetTitle,
      required this.planetInformation,
      required this.image});
  Map<String, dynamic> planetMap() {
    return {
      'planetName': planetName,
      'planetTitle': planetTitle,
      'planetInformation': planetInformation,
      'image': image
    };
  }

  @override
  String toString() {
    return "{planetName: $planetName, planetTitle: $planetTitle, planetInformation: $planetInformation}";
  }
}

class _Planets extends State {
  List planetList = [];
  @override
  void initState() {
    super.initState();
    createDB();
  }

  Future createDB() async {
    planetDatabase = await openDatabase(
      join(await getDatabasesPath(), 'planetsDB1.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE planetTable(
            planetName TEXT PRIMARY KEY,
            planetTitle TEXT,
            planetInformation TEXT,
            image Text
          )
      ''');
      },
    );
    PlanetsInfo obj1 = PlanetsInfo(
        planetName: "Jupiter",
        planetTitle: "Planetary data for Jupiter",
        planetInformation:
            "Jupiter is the fifth planet from the Sun in our solar system. It is a gas giant, primarily composed of hydrogen and helium, similar to Saturn. Jupiter is renowned for its immense size and powerful storms, most notably the Great Red Spot, a massive storm system that has been raging for centuries.",
        image: "images/jupiter.jfif");

    insertDB(obj1);
    planetList = await getPlanetDB();
    setState(() {});
  }

  Future insertDB(PlanetsInfo obj) async {
    final localDB = await planetDatabase;
    await localDB.insert(
      'planetTable',
      obj.planetMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getPlanetDB() async {
    final localDB = await planetDatabase;
    List planetfromDB = await localDB.query('planetTable');
    return planetfromDB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/planetsbg.png",
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
                    "Explore Planets",
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
                        itemCount: planetList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 130,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              color: Colors.white,
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
                                image: AssetImage(planetList[index]['image']),
                                fit: BoxFit.cover,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              planetList[index]['planetName'],
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
