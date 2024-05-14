import "package:flutter/material.dart";
import 'package:interstellar1/landingPage.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'registration.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State createState() => _LoginState();
}

class _LoginState extends State {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passController = TextEditingController();
  List users = [];

  @override
  void initState() {
    super.initState();
    openDB();
  }

  Future openDB() async {
    loginDatabase =
        await openDatabase(join(await getDatabasesPath(), "userDB1.db"));
    users = await getUsers();
    print(users);
    setState(() {});
  }

  Future getUsers() async {
    final localdb = await loginDatabase;
    List userList = await localdb.query(
      "userTable",
    );
    return userList;
  }

  Future printData() async {
    print(await users);
  }

  bool autheticate() {
    bool isUser = false;

    for (var user in users) {
      var username = user['userName'];
      var password = user['password'];

      if (username == usernameController.text &&
          password == passController.text) {
        isUser = true;
        break;
      }
    }
    print(isUser);
    return isUser;
  }

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
                key: loginKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Text("Welcome",
                        style: TextStyle(
                            fontSize: 50,
                            color: Colors.white,
                            fontWeight: FontWeight.w300)),
                    const Text("Back",
                        style: TextStyle(fontSize: 70, color: Colors.white)),
                    const SizedBox(
                      height: 40,
                    ),
                    TextFormField(
                      controller: usernameController,
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.4),
                        hintText: "Username",
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
                          return "Please enter username";
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: passController,
                      obscureText: true,
                      obscuringCharacter: "*",
                      cursorColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: const Color.fromRGBO(255, 255, 255, 0.3),
                        hintText: "Password",
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
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        bool loginValidate = loginKey.currentState!.validate();
                        if (autheticate()) {
                          if (loginValidate) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Center(
                                  child: Text(
                                    "Login Sucessfull",
                                    style: TextStyle(color: Colors.green),
                                  ),
                                ),
                                duration: Duration(seconds: 1),
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LandingPage()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Login Failed",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Center(
                                child: Text(
                                  "Invalid Username or password...!!",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          );
                          usernameController.clear();
                          passController.clear();
                          setState(() {});
                        }
                        printData();
                      },
                      child: Container(
                        height: 60,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: const Center(child: Text("Login")),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Registration()),
                              );
                            },
                            child: const Text(
                              "Creat Account",
                              style: TextStyle(color: Colors.white),
                            )),
                      ],
                    ),
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
