import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/login/login_screen.dart';
import 'package:meeting_app/features/authentication/signup/signup_screen.dart';
import 'package:meeting_app/features/home/widgets/group_chats.dart';
import 'package:meeting_app/features/home/widgets/sidebar_menu.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onSwitchIndexTap(int value) {
    setState(() {
      // a value is the index of Tabbed GButton
      _selectedIndex = value;
    });
  }

  void _onSignUpTap(BuildContext context) {
    context.push(SignupScreen.routeName);
    // Navigator.pushNamed(context, SignupScreen.routeName);
  }

  void _onLoginTap(BuildContext context) {
    context.push(LoginScreen.routeName);
    // Navigator.pushNamed(context, LoginScreen.routeName);
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
              padding: EdgeInsets.only(right: 18),
              child: Text("LogIn"),
            ),
          ),
          GestureDetector(
            onTap: () => _onSignUpTap(context),
            child: const Padding(
              padding: EdgeInsets.only(right: 24),
              child: Text("SignUp"),
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
      body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
            vertical: Sizes.size28,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Offstage(
                  offstage: _selectedIndex != 0,
                  child: const Column(
                    children: [
                      GroupChats(),
                    ],
                  ),
                ),
                Gaps.v16,
                Offstage(
                  offstage: _selectedIndex != 1,
                  child: const OffStateTestWidget(
                    text: "Chat",
                  ),
                ),
                Gaps.v16,
                Offstage(
                  offstage: _selectedIndex != 2,
                  child: const OffStateTestWidget(
                    text: "Search",
                  ),
                ),
                Gaps.v16,
                Offstage(
                  offstage: _selectedIndex != 3,
                  child: const OffStateTestWidget(
                    text: "Heart",
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

// test
class OffStateTestWidget extends StatefulWidget {
  final String? text;
  const OffStateTestWidget({
    super.key,
    this.text,
  });

  @override
  State<OffStateTestWidget> createState() => _OffStateTestWidgetState();
}

class _OffStateTestWidgetState extends State<OffStateTestWidget> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          setState(() {
            _count = _count + 1;
          });
        },
        child: Text("${widget.text} - count is $_count"));
  }
}
