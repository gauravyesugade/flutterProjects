import 'package:flutter/material.dart';
import 'quizPage.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State createState() => _LoginState();
}

class _LoginState extends State {
  GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool pass = true;

  Map userList = {"gaurav": "123", "Rahul": "456"};

  bool autheticate() {
    bool isUser = false;
    for (var entry in userList.entries) {
      var key = entry.key;
      var value = entry.value;
      if (key == userNameController.text && value == passwordController.text) {
        isUser = true;
        break;
      }
    }
    return isUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Center(
          child: AppBar(
            title: const Text(
              "QUIZAPP",
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w800),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Form(
          key: loginKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                controller: userNameController,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person),
                  label: const Text("Enter Username"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
                height: 20,
              ),
              TextFormField(
                controller: passwordController,
                obscureText: pass,
                obscuringCharacter: "*",
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          pass = !pass;
                        });
                      },
                      icon: const Icon(Icons.remove_red_eye)),
                  label: const Text("Enter Password"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  // suffix: const Icon(Icons.remove_red_eye),
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
                height: 20,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    minimumSize: MaterialStatePropertyAll(Size(150, 40)),
                    backgroundColor:
                        MaterialStatePropertyAll(Color(0xFF1E1E2C))),
                onPressed: () {
                  bool loginValidate = loginKey.currentState!.validate();
                  if (autheticate()) {
                    if (loginValidate) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login Sucessfull"),
                          duration: Duration(seconds: 1),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QuizApp()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login Failed"),
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text("Login Failed...!! Enter valid credentials"),
                      ),
                    );
                    userNameController.clear();
                    passwordController.clear();
                    setState(() {});
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
