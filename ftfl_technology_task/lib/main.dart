import 'package:flutter/material.dart';
import 'package:ftfl_technology_task/contain.dart';
import 'package:ftfl_technology_task/screens/cardAndWallets.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CardAndWallets(),
    );
  }
}
