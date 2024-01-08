import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';
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
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color.fromARGB(255, 208, 195, 255),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Color.fromARGB(255, 208, 195, 255),
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w300,
            )),
      ),
      home: const HomeScreen(),
    );
  }
}
