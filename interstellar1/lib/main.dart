import 'package:flutter/material.dart';
import 'LaunchScreen.dart';
import 'arrangeGame.dart';
import 'example.dart';
import 'galaxies.dart';
import 'games.dart';
import 'landingPage.dart';
import 'registration.dart';
import 'stars.dart';
import 'login.dart';
import 'planets.dart';
import 'example.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LaunchScreen(),
      ),
    );
  }
}
