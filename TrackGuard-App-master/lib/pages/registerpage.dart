import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackdemo2/components/my_button.dart';
import 'package:trackdemo2/components/my_textfield.dart';
import 'package:trackdemo2/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;
  const RegisterPage({Key? key, required this.onTap}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  final TextEditingController imei1Controller = TextEditingController();
  final TextEditingController imei2Controller = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  // Register method
  void registerUser() async {
    // Check if any of the fields are empty
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPwController.text.isEmpty ||
        imei1Controller.text.isEmpty ||
        imei2Controller.text.isEmpty ||
        phoneNumberController.text.isEmpty) {
      // Show error message to user if any field is empty
      displayMessageToUser("All fields are required", context);
      return;
    }

    // Show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Check if password matches the confirm password
    if (passwordController.text != confirmPwController.text) {
      // Pop loading circle
      Navigator.pop(context);

      // Show error message to user
      displayMessageToUser("Passwords don't match", context);
      return;
    }

    // Try creating the user
    try {
      // Create user
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.text, password: passwordController.text);

      // Get the user ID
      String userId = userCredential.user!.uid;

      // Save user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': usernameController.text,
        'email': emailController.text,
        'imei1': imei1Controller.text,
        'imei2': imei2Controller
            .text, // Adjust this if you have separate controllers for IMEI1 and IMEI2
        'phone_number': phoneNumberController.text,
      });

      // Pop loading circle
      Navigator.pop(context);

      // Show success message or navigate to the next screen
      displayMessageToUser("Registration successful", context);

      // Navigate to the login page
      if (widget.onTap != null) {
        widget.onTap!();
      }
    } on FirebaseAuthException catch (e) {
      // Pop loading circle
      Navigator.pop(context);

      // Display error message to user
      displayMessageToUser(e.message ?? "An error occurred", context);
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
                // Logo
                Icon(Icons.person,
                    size: 80, color: Theme.of(context).colorScheme.primary),

                const SizedBox(height: 25),
                // App name
                Text(
                  "T R A C K G U A R D",
                  style: GoogleFonts.roboto(
                      fontWeight: FontWeight.bold, fontSize: 20),
                ),

                const SizedBox(height: 25),
                // Username text field
                MyTextField(
                  hintText: "Username",
                  obscureText: false,
                  controller: usernameController,
                  icon: Icons.person,
                ),
                const SizedBox(height: 14),

                // Email text field
                MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                  icon: Icons.email,
                ),
                const SizedBox(height: 14),

                // Password text field
                MyTextField(
                  hintText: "Password",
                  obscureText: true,
                  controller: passwordController,
                  icon: Icons.lock,
                ),
                const SizedBox(height: 10),

                // Confirm password text field
                MyTextField(
                  hintText: "Confirm Password",
                  obscureText: true,
                  controller: confirmPwController,
                  icon: Icons.lock,
                ),

                const SizedBox(height: 14),

                // IMEI Number text field
                MyTextField(
                  hintText: "IMEI Number 1",
                  obscureText: false,
                  controller: imei1Controller,
                  icon: Icons.phone_android,
                ),

                const SizedBox(height: 14),

                // IMEI Number text field
                MyTextField(
                  hintText: "IMEI Number 2",
                  obscureText: false,
                  controller: imei2Controller,
                  icon: Icons.phone_android,
                ),

                const SizedBox(height: 14),

                // Phone Number text field
                MyTextField(
                  hintText: "Phone Number",
                  obscureText: false,
                  controller: phoneNumberController,
                  icon: Icons.phone,
                ),

                const SizedBox(height: 25),

                // Register button
                MyButton(text: "SignUp", onTap: registerUser),

                const SizedBox(height: 25),

                // Don't have an account, Signup button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already Have an Account!! "),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Login Here",
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
