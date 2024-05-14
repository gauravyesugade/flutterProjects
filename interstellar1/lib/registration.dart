import "package:flutter/material.dart";
import 'login.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic loginDatabase;

class Registration extends StatefulWidget {
  const Registration({super.key});
  @override
  State createState() => _RegistrationState();
}

class _RegistrationState extends State {
  @override
  void initState() {
    super.initState();
    creatDB();
  }

  void creatDB() async {
    loginDatabase = openDatabase(join(await getDatabasesPath(), "userDB1.db"),
        version: 1, onCreate: (db, version) {
      db.execute(
        '''
            CREATE TABLE userTable(
              name TEXT,
              userName TEXT PRIMARY KEY,
              password TEXT 
            )''',
      );
    });
    setState(() {});
  }

  Future insertIntoDB(User obj) async {
    final localdb = await loginDatabase;
    await localdb.insert(
      "userTable",
      obj.toUserMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    //print(await getUsers());
  }

  Future getUsers() async {
    final localdb = await loginDatabase;
    List userList = await localdb.query(
      "userTable",
    );
    return userList;
  }

  Future printData() async {
    print(await getUsers());
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> registrationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset(
              "images/log1.png",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
              child: Form(
                key: registrationKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text("Let's",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                    const Text("Start",
                        style: TextStyle(fontSize: 70, color: Colors.white)),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: nameController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                        hintText: "Enter your name",
                        suffixIcon: const Icon(
                          Icons.abc,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Name";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: userNameController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                        hintText: "Enter username",
                        suffixIcon: const Icon(
                          Icons.email,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Username";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                        hintText: "Enter password",
                        suffixIcon: const Icon(
                          Icons.lock,
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter Password";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    GestureDetector(
                      onTap: () {
                        bool validate =
                            registrationKey.currentState!.validate();
                        if (validate) {
                          insertIntoDB(
                            User(
                              name: nameController.text,
                              userName: userNameController.text,
                              password: passwordController.text,
                            ),
                          );
                          printData();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        }

                        setState(() {});
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(child: Text("Register")),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  String userName;
  String password;

  User({required this.name, required this.userName, required this.password});

  Map<String, dynamic> toUserMap() {
    return {
      'name': name,
      'userName': userName,
      'password': password,
    };
  }

  @override
  String toString() {
    return "{name:$name, userName:$userName, password:$password}";
  }
}
