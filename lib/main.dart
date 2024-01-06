import 'package:flutter/material.dart';
import 'package:meeting_app/screens/home_screen.dart';

void main() {
  runApp(const MeetingApp());
}

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(185, 168, 248, 1),
      ),
      home: HomeScreen(),
    );
  }
}
