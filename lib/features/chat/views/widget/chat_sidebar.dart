import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ChatSideBar extends StatelessWidget {
  const ChatSideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(FontAwesomeIcons.toolbox),
            title: const Text('방 설정 변경'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('방 나가기'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
