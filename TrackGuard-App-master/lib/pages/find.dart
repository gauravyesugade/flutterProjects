import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:permission_handler/permission_handler.dart';

class DisplayLocationScreen extends StatefulWidget {
  const DisplayLocationScreen({super.key});

  @override
  State createState() => _DisplayLocationScreenState();
}

class _DisplayLocationScreenState extends State<DisplayLocationScreen> {
  Position? _currentPosition;
  String _locationMessage = "Getting Location...";
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _requestPermissions().then((_) {
      _startLocationUpdates();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _startLocationUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 15), (Timer t) async {
      await _getCurrentLocation();
    });
  }

  Future<void> _requestPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      var backgroundStatus = await Permission.locationAlways.request();
      if (!backgroundStatus.isGranted) {
        setState(() {
          _locationMessage = 'Background location permission denied';
        });
      }
    } else {
      setState(() {
        _locationMessage = 'Foreground location permission denied';
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Location permissions are denied.';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Location permissions are permanently denied.';
      });
      return;
    }

    try {
      Position newPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = newPosition;
        _locationMessage =
            'Location: \nLat: ${_currentPosition!.latitude}, \nLong: ${_currentPosition!.longitude}';
      });

      // Save coordinates to Firestore
      saveCoordinatesToFirestore(
          _currentPosition!.latitude, _currentPosition!.longitude);
    } catch (e) {
      print(e.toString());
      setState(() {
        _locationMessage = 'Error getting location: ${e.toString()}';
      });
    }
  }

  void saveCoordinatesToFirestore(double latitude, double longitude) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        await users.doc(user.uid).set({
          'latitude': latitude,
          'longitude': longitude,
        });
        print('Coordinates saved to Firestore.');
      }
    } catch (e) {
      print('Error saving coordinates to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TrackGuard",
          style: TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(205, 218, 218, 1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 200,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 17,
              ),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(143, 148, 251, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                _locationMessage,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                if (_currentPosition != null) {
                  MapsLauncher.launchCoordinates(
                      _currentPosition!.latitude, _currentPosition!.longitude);
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width - 200,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 17,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(143, 148, 251, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "LAUNCH COORDINATES",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
