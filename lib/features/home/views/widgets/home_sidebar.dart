import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:meeting_app/features/laboratory/test/riverpod_test_screen.dart";
import "package:meeting_app/features/laboratory/videos/video_screen.dart";
import 'package:meeting_app/features/user_account/views/user_profile_screen.dart';

Widget buildMenuItems(BuildContext context) => SafeArea(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('내 정보'),
            onTap: () {
              context.pushNamed(ProfileScreen.routeName);
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('기록'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('환경설정'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.science),
            title: const Text('실험실'),
            onTap: () {
              // context.pushNamed(VideoScreen.routeName);
              context.pushNamed(RiverpodTestScreen.routeName);
            },
          ),
        ],
      ),
    );

class HomeSideBar extends StatelessWidget {
  const HomeSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildMenuItems(context),
        ],
      )),
    );
  }
}
