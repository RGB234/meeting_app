import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/screens/login_screen.dart';
import 'package:meeting_app/screens/signup_screen.dart';
import 'package:meeting_app/widgets/bottom_navigation_bar.dart';
import 'package:meeting_app/widgets/sidebar_menu.dart';
import "../widgets/group_chats.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onSignUpTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  void onLoginTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 8,
        title: const Text("{대충계정명}"),
        actions: [
          GestureDetector(
            onTap: () => onLoginTap(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Login"),
            ),
          ),
          GestureDetector(
            onTap: () => onSignUpTap(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
      drawer: const SideBarMenu(),
      bottomNavigationBar: const BottomNavBar(),
      body: const SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Sizes.size36,
            vertical: Sizes.size28,
          ),
          child: Column(
            children: [
              GroupChats(),
            ],
          ),
        ),
      ),
    );
  }
}

//

