import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic galaxyDatabase;

class Galaxy extends StatefulWidget {
  const Galaxy({super.key});
  @override
  State createState() => _GalaxyState();
}

class GalaxyInfo {
  String galaxyName;
  String galaxyTitle;
  String galaxyInformation;
  String image;

  GalaxyInfo(
      {required this.galaxyName,
      required this.galaxyTitle,
      required this.galaxyInformation,
      required this.image});
  Map<String, dynamic> galaxyMap() {
    return {
      'galaxyName': galaxyName,
      'galaxyTitle': galaxyTitle,
      'galaxyInformation': galaxyInformation,
      'image': image
    };
  }

  // @override
  // String toString() {
  //   return "{planetName: $starName, planetTitle: $starTitle, planetInformation: $starInformation}";
  // }
}

class _GalaxyState extends State {
  List galaxyList = [];
  @override
  void initState() {
    super.initState();
    createDB();
  }

  Future createDB() async {
    galaxyDatabase = await openDatabase(
      join(await getDatabasesPath(), 'galaxyDB.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE galaxyTable(
            galaxyName TEXT PRIMARY KEY,
            galaxyTitle TEXT,
            galaxyInformation TEXT,
            image Text
          )
      ''');
      },
    );
    GalaxyInfo obj = GalaxyInfo(
      galaxyName: "Cigar Galaxy",
      galaxyTitle: "Galactic Data for Cigar Galaxy (Messier 82)",
      galaxyInformation:
          "The Cigar Galaxy, also known as Messier 82 (M82), is a starburst galaxy located approximately 12 million light-years away from Earth in the constellation Ursa Major. It is named for its elongated shape, resembling a cigar, and is one of the nearest and brightest galaxies of its kind. M82 is undergoing intense star formation activity, with regions of high energy and massive star clusters. This activity is thought to be driven by gravitational interactions with its larger neighbor, the Bode's Galaxy (M81). The Cigar Galaxy has a diameter of about 37,000 light-years and contains billions of stars. It is a popular target for astronomers studying starburst galaxies, galactic winds, and cosmic evolution.",
      image: "images/cigar.jpg",
    );

    insertDB(obj);
    galaxyList = await getgalaxyDB();
    setState(() {});
  }

  Future insertDB(GalaxyInfo obj) async {
    final localDB = await galaxyDatabase;
    await localDB.insert(
      'galaxyTable',
      obj.galaxyMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getgalaxyDB() async {
    final localDB = await galaxyDatabase;
    List galaxyfromDB = await localDB.query('galaxyTable');
    return galaxyfromDB;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/galaxybg.jpg",
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
                    "Explore Galaxies",
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
                        itemCount: galaxyList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            height: 130,
                            padding: const EdgeInsets.all(20),
                            margin: const EdgeInsets.only(bottom: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  spreadRadius: 1,
                                  color: Color.fromRGBO(255, 255, 255, 0.45),
                                )
                              ],
                              //color: Colors.white,
                              image: DecorationImage(
                                  image: AssetImage(galaxyList[index]['image']),
                                  fit: BoxFit.cover),
                            ),
                            alignment: Alignment.topLeft,
                            child: Text(
                              galaxyList[index]['galaxyName'],
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
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: Colors.white,
      //       ),
      //       label: 'Tab 1',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'Tab 2',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       label: 'Tab 3',
      //     ),
      //   ],
      //   selectedItemColor: Colors.blue,
      // ),
    );
  }
}
