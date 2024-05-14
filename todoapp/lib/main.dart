import 'package:flutter/material.dart';
import 'package:path/path.dart' as pt;
import 'package:intl/intl.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sqflite/sqflite.dart';

dynamic database;

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: QuizApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({super.key});
  @override
  State createState() => _MainAppState();
}

class ToDoModelClass {
  int? cardIndex;
  String title;
  String description;
  String date;
  ToDoModelClass({
    this.cardIndex,
    required this.title,
    required this.description,
    required this.date,
  });
  Map<String, dynamic> cardMap() {
    return {"title": title, 'desc': description, 'date': date};
  }

  @override
  String toString() {
    return "{ title: $title, description: $description, date:$date }";
  }
}

class _MainAppState extends State {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  GlobalKey<FormState> validKey = GlobalKey<FormState>();
  List<ToDoModelClass> cards = [];
  bool checked = false;

  @override
  void initState() {
    super.initState();
    cardsTodb();
    setState(() {});
  }

  void cardsTodb() async {
    database = openDatabase(
      pt.join(await getDatabasesPath(), "cardsDB1.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
            '''CREATE TABLE cards(cardIndex INTEGER PRIMARY KEY, title TEXT , desc TEXT, date TEXT)''');
      },
    );
    cards = await getCards();
    setState(() {});
  }

  void clearController() {
    titleController.clear();
    descController.clear();
    dateController.clear();
  }

//// Retrive from DataBase ----------------------------------------------------------------------
  Future<List<ToDoModelClass>> getCards() async {
    final localdb = await database;
    List cardlist = await localdb.query("cards");
    return List.generate(cardlist.length, (i) {
      return ToDoModelClass(
        cardIndex: cardlist[i]['cardIndex'],
        title: cardlist[i]['title'],
        description: cardlist[i]['desc'],
        date: cardlist[i]['date'],
      );
    });
  }

//// DeleteFromDB Card ----------------------------------------------------------------------------
  Future deleteFromDB(ToDoModelClass obj) async {
    final localdb = await database;
    await localdb.delete(
      "cards",
      where: "cardIndex=?",
      whereArgs: [obj.cardIndex],
    );

    print(await getCards());
  }

  //// Delete Card -----------------------------------------------------------------------
  void deleteCard(ToDoModelClass obj) async {
    deleteFromDB(obj);
    cards = await getCards();
    setState(() {});
  }

//// Insert Into DataBase -------------------------------------------------------------------
  Future<void> addToDatabase(obj) async {
    final localdb = await database;
    await localdb.insert(
      "cards",
      obj.cardMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //// Update Database ------------------------------------------------------------------------
  Future<void> updateDatabase(ToDoModelClass obj) async {
    final localdb = await database;
    localdb.update("cards", obj.cardMap(),
        where: 'cardIndex = ?', whereArgs: [obj.cardIndex]);
    cards = await getCards();
    setState(() {});
  }

  //// Submit Card ----------------------------------------------------------------------------
  void submitData(bool doEdit, [ToDoModelClass? toDoModelobj]) async {
    if (titleController.text.trim().isNotEmpty &&
        descController.text.trim().isNotEmpty &&
        dateController.text.trim().isNotEmpty) {
      if (!doEdit) {
        addToDatabase(
          ToDoModelClass(
            title: titleController.text,
            description: descController.text,
            date: dateController.text,
          ),
        );
        Navigator.pop(context);
        clearController();
      } else {
        setState(() {
          toDoModelobj!.title = titleController.text;
          toDoModelobj.description = descController.text;
          toDoModelobj.date = dateController.text;
        });
        await updateDatabase(toDoModelobj!);

        clearController();
        Navigator.pop(context);
      }
    }
    cards = await getCards();
    print(await getCards());
    setState(() {});
  }

//// Edit Card -------------------------------------------------------------------------
  void editCard(ToDoModelClass toDoModelobj) {
    titleController.text = toDoModelobj.title;
    descController.text = toDoModelobj.description;
    dateController.text = toDoModelobj.date;
    bottomSheet(true, toDoModelobj);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: const Text(
                "Good Morning",
                style: TextStyle(fontSize: 40),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 35),
              child: const Text(
                "Gauravvv",
                style: TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(217, 217, 217, 1),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      width: double.infinity,
                      height: 20,
                    ),
                    const Text("CREATE TODO LIST"),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(top: 50),
                        decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: ListView.builder(
                          itemCount: cards.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              endActionPane: ActionPane(
                                extentRatio: 0.3,
                                motion: const DrawerMotion(),
                                children: [
                                  SlidableAction(
                                    onPressed: (context) {
                                      editCard(cards[index]);
                                    },
                                    icon: Icons.edit,
                                  ),
                                  SlidableAction(
                                    onPressed: (context) {
                                      deleteCard(cards[index]);
                                    },
                                    icon: Icons.delete,
                                  )
                                ],
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.only(bottom: 20),
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(255, 255, 255, 1),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                    )
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      "images/img3.webp",
                                      width: 35,
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            cards[index].title,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 4,
                                          ),
                                          Text(
                                            cards[index].description,
                                            textAlign: TextAlign.justify,
                                            style: const TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            cards[index].date,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Checkbox(
                                      value: false,
                                      onChanged: (val) {},
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(111, 81, 255, 1),
          onPressed: () {
            bottomSheet(false);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

//// Bottom Sheet -----------------------------------------------------------------------
  Future<dynamic> bottomSheet(
    bool? isEdit, [
    ToDoModelClass? toDoModelobj,
  ]) {
    return showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Form(
              key: validKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Create Tasks"),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add title"),
                      const SizedBox(
                        width: 50,
                      ),
                      TextFormField(
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter title";
                          } else {
                            return null;
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add Task"),
                      const SizedBox(
                        width: 50,
                      ),
                      TextFormField(
                        controller: descController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter description";
                          } else {
                            return null;
                          }
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Add Date"),
                      const SizedBox(
                        width: 50,
                      ),
                      TextFormField(
                        readOnly: true,
                        controller: dateController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          suffix: Icon(Icons.calendar_month),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2024),
                              lastDate: DateTime(2025));
                          String formatedDate =
                              DateFormat.yMMMMd().format(pickedDate!);
                          setState(() {
                            dateController.text = formatedDate;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter date";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                        Color.fromRGBO(2, 167, 177, 1),
                      ),
                    ),
                    onPressed: () {
                      bool submitValidator = validKey.currentState!.validate();
                      if (!isEdit!) {
                        submitData(isEdit);
                      } else {
                        submitData(isEdit, toDoModelobj);
                      }
                    },
                    child: const Text("Submit"),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
