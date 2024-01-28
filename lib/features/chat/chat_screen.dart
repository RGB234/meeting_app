import 'package:flutter/material.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/chat/widget/bottom_textfield.dart';
import 'package:meeting_app/features/chat/widget/message.dart';

class ChatScreen extends StatefulWidget {
  static const routeName = "chatroom";
  static const routeRoute = "/:chatId";
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            ListView.separated(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(
                left: Sizes.size10,
                right: Sizes.size10,
                top: Sizes.size24,
                bottom: Sizes.size96,
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
            CustomBottomTextField(),
          ],
        ),
      ),
    );
  }
}
