import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trackdemo2/components/my_button.dart';
import 'package:trackdemo2/components/my_textfield.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _currentPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                hintText: 'Current Password',
                obscureText: true,
                controller: _currentPasswordController,
                icon: Icons.lock,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: 'New Password',
                obscureText: true,
                controller: _newPasswordController,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 20),
              MyTextField(
                hintText: 'Confirm New Password',
                obscureText: true,
                controller: _confirmNewPasswordController,
                icon: Icons.lock_outline,
              ),
              const SizedBox(height: 40),
              MyButton(
                text: 'Confirm',
                onTap: () async {
                  String currentPassword = _currentPasswordController.text;
                  String newPassword = _newPasswordController.text;
                  String confirmNewPassword =
                      _confirmNewPasswordController.text;

                  // Check if new password and confirm new password match
                  if (newPassword != confirmNewPassword) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('New password does not match confirmation')),
                    );
                    return;
                  }

                  try {
                    User? user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      // Re-authenticate user with current password
                      AuthCredential credential = EmailAuthProvider.credential(
                          email: user.email!, password: currentPassword);
                      await user.reauthenticateWithCredential(credential);

                      // Update password
                      await user.updatePassword(newPassword);

                      // Display success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Password updated successfully')),
                      );

                      // Close the page
                      Navigator.pop(context);
                    }
                  } catch (error) {
                    // Display error message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Failed to update password: $error')),
                    );
                  }
                },
              ),
              const SizedBox(height: 20),
              MyButton(
                text: 'Cancel',
                onTap: () {
                  // Close the page
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
