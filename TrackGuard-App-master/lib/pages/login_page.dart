import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackdemo2/components/my_button.dart';
import 'package:trackdemo2/components/my_textfield.dart';
import 'package:trackdemo2/helper/helper_function.dart';
import 'package:trackdemo2/pages/forget_passward.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedDeviceType;

  // login method
  void login() async {
    // show loading circle
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    // try sign in
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // update device type in Firestore
      if (userCredential.user != null && selectedDeviceType != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({'deviceType': selectedDeviceType}, SetOptions(merge: true));
      }

      // pop loading circle
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // pop loading circle
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60), // Add some space from top
                // logo
                Icon(Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary),

                const SizedBox(height: 25),
                // app name
                Text(
                  "T R A C K G U A R D",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),

                const SizedBox(height: 25),

                // email textfield
                MyTextField(
                    hintText: "Email",
                    obscureText: false,
                    controller: emailController,
                    icon: Icons.email),

                const SizedBox(height: 14),

                // password textfield
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 25),

                // device type selection
                SizedBox(
                  height: 50, // Adjust the height as needed
                  child: DropdownButtonFormField<String>(
                    value: selectedDeviceType,
                    onChanged: (value) {
                      setState(() {
                        selectedDeviceType = value;
                      });
                    },
                    items: const [
                      DropdownMenuItem(
                        value: "base_phone",
                        child: Text("Base Phone"),
                      ),
                      DropdownMenuItem(
                        value: "track_phone",
                        child: Text("Track Phone"),
                      ),
                    ],
                    hint: const Text("Select Device Type"),
                  ),
                ),

                const SizedBox(height: 10),

                // forgot password
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: GoogleFonts.roboto(
                            color: Theme.of(context).colorScheme.secondary),
                      ),
                    )
                  ],
                ),

                const SizedBox(height: 25),

                // login button
                MyButton(text: "Login", onTap: login),

                const SizedBox(height: 25),

                // Don't have account, Signup button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Here",
                        style: GoogleFonts.roboto(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
