import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trackdemo2/components/my_button.dart';
import 'package:trackdemo2/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();
  void sendPasswordResetEmail() async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: emailController.text,
      );

      Navigator.pop(context);

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password reset email sent!"),
        ),
      );
      // Navigate back to login page immediately
      Navigator.pop(
          context); // Navigate back to the previous screen (Login Page)
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      // Show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "An error occurred"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(Icons.person,
                  size: 80,
                  color: Theme.of(context).colorScheme.inversePrimary),

              const SizedBox(height: 25),
              //app name

              Text(
                "T R A C K G U A R D",
                style: GoogleFonts.roboto(
                    fontWeight: FontWeight.bold, fontSize: 20),
              ),

              const SizedBox(height: 25),
              // Email text field
              MyTextField(
                  hintText: "Email",
                  obscureText: false,
                  controller: emailController,
                  icon: Icons.email),
              const SizedBox(height: 25),
              // Send reset email button
              MyButton(
                text: "Send Reset Link",
                onTap: sendPasswordResetEmail,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
