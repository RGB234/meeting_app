import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/screens/authentication/login/login_screen.dart';
import 'package:meeting_app/screens/authentication/signup/signup_screen.dart';
import 'package:meeting_app/widgets/sidebar_menu.dart';
import "../widgets/group_chats.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  List<Widget> screens = [
    const Column(
      children: [
        GroupChats(),
      ],
    ),
    const Column(
      children: [
        Text("Chat"),
      ],
    ),
    const Column(
      children: [
        Text("Search"),
      ],
    ),
    const Column(
      children: [
        Text("Like"),
      ],
    ),
  ];

  void _onSwitchIndexTap(int value) {
    setState(() {
      // a value is the index of Tabbed GButton
      _selectedIndex = value;
    });
  }

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    ));
  }

  void _onLoginTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("{대충계정명}"),
        actions: [
          GestureDetector(
            onTap: () => _onLoginTap(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Login"),
            ),
          ),
          GestureDetector(
            onTap: () => _onSignUpTap(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text("Sign in"),
            ),
          ),
        ],
      ),
      drawer: const SideBarMenu(),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (value) => _onSwitchIndexTap(value),
        gap: 4,
        tabs: const [
          GButton(
            iconSize: Sizes.size32,
            icon: Icons.house_outlined,
            text: "Home",
          ),
          GButton(
            icon: FontAwesomeIcons.comment,
            text: "Chat",
          ),
          GButton(
            icon: FontAwesomeIcons.magnifyingGlass,
            text: "Search",
          ),
          GButton(
            icon: FontAwesomeIcons.heart,
            text: "Like",
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
          vertical: Sizes.size28,
        ),
        child: screens[_selectedIndex],
      ),
    );
  }
}
