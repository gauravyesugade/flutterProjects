import 'package:trackdemo2/pages/find.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// HomeScreen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedDeviceType;
  bool isLoading = true;

  // Update initState() in HomeScreen to call fetchDeviceType()
  @override
  void initState() {
    super.initState();
    fetchDeviceType();
  }

  // Update fetchDeviceType() method in HomeScreen
  Future<void> fetchDeviceType() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (snapshot.exists) {
        setState(() {
          selectedDeviceType = snapshot.get('deviceType');
          isLoading = false;
        });
      }
    }
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> launchCoordinatesOnMap(double latitude, double longitude) async {
    MapsLauncher.launchCoordinates(latitude, longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          gradient: const LinearGradient(
            colors: [
              Color.fromRGBO(143, 148, 251, 1),
              Color.fromRGBO(143, 148, 251, .6),
            ],
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const SizedBox(
              width: 300,
              height: 92,
              child: Column(
                children: [
                  Text(
                    "Welcome To the",
                    style: TextStyle(fontSize: 27, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Trackguard",
                    style: TextStyle(fontSize: 37, fontWeight: FontWeight.w700),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (selectedDeviceType == 'base_phone')
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(300, 60),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const DisplayLocationScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Find My Devices',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          const SizedBox(
                            height: 20,
                          ),
                          if (selectedDeviceType == 'track_phone')
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(300, 60),
                              ),
                              onPressed: () async {
                                final currentUser =
                                    FirebaseAuth.instance.currentUser;
                                if (currentUser != null) {
                                  final snapshot = await FirebaseFirestore
                                      .instance
                                      .collection('users')
                                      .doc(currentUser.uid)
                                      .get();

                                  if (snapshot.exists) {
                                    final data = snapshot.data();
                                    final latitude =
                                        data?['latitude'] as double?;
                                    final longitude =
                                        data?['longitude'] as double?;

                                    if (latitude != null && longitude != null) {
                                      await launchCoordinatesOnMap(
                                          latitude, longitude);
                                    } else {
                                      print('Latitude or longitude is null.');
                                    }
                                  } else {
                                    print('Document does not exist.');
                                  }
                                } else {
                                  print('Current user not found.');
                                }
                              },
                              child: const Text(
                                'Track',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
