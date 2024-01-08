import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';

class EmailLogInScreen extends StatelessWidget {
  const EmailLogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: const Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Sizes.size36,
          vertical: Sizes.size28,
        ),
        child: Column(children: [
          Text("Email Login screen"),
        ]),
      ),
    );
  }
}
