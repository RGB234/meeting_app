import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/authentication/screens/signin/signin_screen.dart';
import 'package:meeting_app/features/authentication/screens/register/register_screen.dart';
import 'package:meeting_app/features/authentication/view_models/register_view_model.dart';
import 'package:meeting_app/features/home/widgets/group_chats.dart';
import 'package:meeting_app/features/home/widgets/sidebar_menu.dart';

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
    ref.read(registerProvider.notifier).signOut();
  }

  @override
  Widget build(BuildContext context) {
    // rebuild when authState is changed.
    ref.watch(authState);
    return Scaffold(
      appBar: AppBar(
        elevation: 1.5,
        shadowColor: Colors.black87,
        title: const Text("{대충계정명}"),
        actions: [
          ref.read(registerProvider.notifier).isSignedIn()
              ? Row(
                  children: [
                    GestureDetector(
                      onTap: () => _onSignOutTap(),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: Text("Sign out"),
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
                        child: Text("Sign in"),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _onRegisterTap(context),
                      child: const Padding(
                        padding: EdgeInsets.only(right: 24),
                        child: Text("Register"),
                      ),
                    ),
                  ],
                )
        ],
      ),
      drawer: const SideBarMenu(),
      bottomNavigationBar: GNav(
        selectedIndex: _selectedIndex,
        onTabChange: (value) => _onSwitchIndexTap(value),
        gap: 4,
        tabs: const [
          GButton(
            iconSize: Sizes.size24,
            icon: Icons.house_outlined,
            text: "Home",
          ),
          GButton(
            iconSize: Sizes.size20,
            icon: FontAwesomeIcons.comment,
            text: "Chat",
          ),
          GButton(
            iconSize: Sizes.size20,
            icon: FontAwesomeIcons.magnifyingGlass,
            text: "Explore",
          ),
          GButton(
            iconSize: Sizes.size20,
            icon: FontAwesomeIcons.heart,
            text: "Likes",
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(
              Sizes.size32, Sizes.size24, Sizes.size32, 0),
          child: Stack(
            children: [
              Offstage(
                offstage: _selectedIndex != 0,
                child: const OffStateTestWidget(
                  text: "Home",
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
                child: const GroupChats(),
              ),
              Gaps.v16,
              Offstage(
                offstage: _selectedIndex != 3,
                child: const OffStateTestWidget(
                  text: "Likes",
                ),
              ),
            ],
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
