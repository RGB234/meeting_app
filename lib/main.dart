import 'package:flutter/material.dart';
import 'package:meeting_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorSchemeSeed: const Color(0xb9a8f8),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
