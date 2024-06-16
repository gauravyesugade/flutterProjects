import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trackdemo2/pages/aboutpage%20.dart';
import 'package:trackdemo2/pages/accountdetailsscreen%20.dart';
import 'package:trackdemo2/pages/changepasswordpage%20.dart';
import 'package:trackdemo2/pages/feedback.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  void logout() {
    FirebaseAuth.instance.signOut();
  }

  String? username;
  String? profileImagePath;
  String? profileImageUrl;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      setState(() {
        username = userDoc['username'];
        profileImageUrl = userDoc['profileImageUrl'];
      });
    }
  }

  void _editProfileImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        profileImagePath = pickedImage.path;
      });
      await _uploadProfileImage(File(pickedImage.path));
    }
  }

  Future<void> _uploadProfileImage(File imageFile) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        // Upload to Firebase Storage
        String filePath = 'profile_images/${user.uid}.png';
        Reference storageReference =
            FirebaseStorage.instance.ref().child(filePath);
        UploadTask uploadTask = storageReference.putFile(imageFile);
        TaskSnapshot snapshot = await uploadTask;
        String downloadUrl = await snapshot.ref.getDownloadURL();

        // Update Firestore
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'profileImageUrl': downloadUrl,
        });

        // Update the state
        setState(() {
          profileImageUrl = downloadUrl;
        });
      } catch (e) {
        // Handle errors
        print('Error uploading profile image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(143, 148, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: _editProfileImage,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight * 0.0),
                width: screenWidth * 0.4,
                height: screenHeight * 0.1,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: profileImageUrl != null
                        ? NetworkImage(profileImageUrl!)
                        : const NetworkImage(
                            "https://e7.pngegg.com/pngimages/627/693/png-clipart-computer-icons-user-user-icon-face-monochrome-thumbnail.png",
                          ) as ImageProvider,
                    fit: BoxFit
                        .cover, // This ensures the image fits the container
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: screenHeight * 0.0),
              width: screenWidth * 0.8,
              child: Column(
                children: [
                  Text(
                    username ?? "Loading...",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "TrackGuard Premium Member",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 220, 220),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 0.4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Inside _AccountScreenState class
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackPage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.feedback,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Feedback",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),

                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AccountDetailsScreen(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.supervisor_account_rounded,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Account",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                top: screenHeight * 0.05,
                left: screenWidth * 0.05,
                right: screenWidth * 0.05,
                bottom: screenHeight * 0.05,
              ),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 224, 220, 220),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 0.4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.notifications_active,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Notification",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next_sharp),
                    ],
                  ),
                  const Divider(),
                  const Row(
                    children: [
                      Icon(
                        Icons.perm_device_info_rounded,
                        size: 25,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Device",
                        style: TextStyle(fontSize: 20),
                      ),
                      Spacer(),
                      Icon(Icons.navigate_next_sharp),
                    ],
                  ),
                  const Divider(),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordPage(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.key_rounded,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Password",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),
                  const Divider(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AboutPage()),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "About",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),
                  const Divider(),
                  InkWell(
                    onTap: logout,
                    child: const Row(
                      children: [
                        Icon(
                          Icons.logout,
                          size: 25,
                        ),
                        SizedBox(width: 10),
                        Text(
                          "Logout",
                          style: TextStyle(fontSize: 20),
                        ),
                        Spacer(),
                        Icon(Icons.navigate_next_sharp),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
