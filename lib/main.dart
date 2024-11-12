import 'package:flutter/material.dart';
import 'package:mysimplenote/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Simple Note',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          brightness: Brightness.dark
      ),
      home: const HomeScreen(),
    );
  }
}

