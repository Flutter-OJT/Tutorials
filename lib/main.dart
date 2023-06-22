import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

///MyApp
///
///@author HeinhtetLinn
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
      ),
      home: HomeScreen(),
    );
  }
}


