import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
// import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:meeting_app/features/laboratory/videos/video_screen.dart";

Widget buildMenuItems(BuildContext context) => Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('내 정보'),
          onTap: () {},
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
            context.pushNamed(VideoScreen.routeName);
          },
        ),
      ],
    );

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({super.key});

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
