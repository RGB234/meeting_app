import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/chat/widget/message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "chat";
  static const routeRoute = "chat";
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size10,
              vertical: Sizes.size24,
            ),
            itemCount: 7,
            itemBuilder: (context, index) {
              if (index % 3 == 0) {
                return const Message(
                  isMyMessage: true,
                );
              }
              return const Message();
            },
            separatorBuilder: (context, index) => Gaps.v16,
          ),
          Positioned(
            width: size.width,
            bottom: 0,
            child: const BottomAppBar(
              child: Row(children: [
                Expanded(child: TextField()),
                Gaps.h12,
                FaIcon(FontAwesomeIcons.xmark),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
