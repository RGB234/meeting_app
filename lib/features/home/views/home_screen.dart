import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/views/signin/signin_screen.dart';
import 'package:meeting_app/features/authentication/views/register/register_screen.dart';
import 'package:meeting_app/features/authentication/view_models/register_view_model.dart';
import 'package:meeting_app/features/authentication/view_models/signout_view_model.dart';
import 'package:meeting_app/features/home/views/explore_screen.dart';
import 'package:meeting_app/features/home/views/my_chat_screen.dart';
import 'package:meeting_app/features/home/views/widgets/sidebar_menu.dart';

class HomeScreen extends ConsumerStatefulWidget {
  static String routePath = "/:tab(home|chat|explore|likes)";
  static String routeName = "home";
  final String tab;
  const HomeScreen({
    super.key,
    required this.tab,
  });

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final List<String> _tabOpt = ["home", "chat", "explore", 'likes'];
  late int _selectedIndex = _tabOpt.indexOf(widget.tab);

  void _onSwitchIndexTap(int value) {
    setState(() {
      _selectedIndex = value;
    });

    context.go("/${_tabOpt[_selectedIndex]}");
  }

  void _onRegisterTap(BuildContext context) {
    context.pushNamed(RegisterScreen.routeName);
  }

  void _onSigninTap(BuildContext context) {
    context.pushNamed(SigninScreen.routeName);
  }

  void _onSignOutTap() {
    ref.read(signOutProvider.notifier).signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // shadowColor: Colors.grey,
        title: Text(
          "Marigold",
          style: TextStyle(
            fontFamily: 'Telma',
            fontWeight: FontWeight.w500,
            fontSize: Sizes.size20,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          ref.read(registerProvider.notifier).isSignedIn()
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () => _onSignOutTap(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text(
                          "Sign out",
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
                  children: [
                    GestureDetector(
                      onTap: () => _onSigninTap(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text(
                          "Sign in",
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onRegisterTap(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Text(
                          "Register",
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
      drawer: const SideBarMenu(),
      bottomNavigationBar: CupertinoTabBar(
        // height: Sizes.size60,
        // border: const Border(top: BorderSide(width: 0)),
        backgroundColor: Colors.white70,
        currentIndex: _selectedIndex,
        activeColor: Theme.of(context).primaryColor,
        onTap: (value) {
          if (!mounted) return;
          return _onSwitchIndexTap(value);
        },
        items: const [
          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.house_outlined),
            label: "Home",
          ),
          // Chat
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.comment),
            label: "Chat",
          ),
          // Explore
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.magnifyingGlass),
            label: "Explore",
          ),
          // Likes
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.heart),
            label: "Likes",
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.size24, Sizes.size12, Sizes.size24, 0),
          child: Stack(
            children: [
              Offstage(
                offstage: _selectedIndex != 0,
                child: const Center(
                  child: Text("Under construction"),
                ),
              ),
              Gaps.v16,
              Offstage(
                offstage: _selectedIndex != 1,
                child: const MyChatScreen(),
              ),
              Gaps.v16,
              Offstage(
                offstage: _selectedIndex != 2,
                child: const ExploreScreen(),
              ),
              Gaps.v16,
              Offstage(
                offstage: _selectedIndex != 3,
                child: const Center(
                  child: Text("Under construction"),
                ),
              ),
            ],
          )),
    );
  }
}
