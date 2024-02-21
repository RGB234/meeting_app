import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/chat/view_models/message_view_model.dart';
import 'package:meeting_app/features/chat/views/widget/bottom_textfield.dart';
import 'package:meeting_app/features/chat/views/widget/message.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = "chatroom";
  static const routePath = "/chat/:chatId";
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
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
            ref.watch(messageStreamProvider(widget.chatId)).when(
                  data: (data) {
                    return ListView.separated(
                      scrollDirection: Axis.vertical,
                      padding: const EdgeInsets.only(
                        left: Sizes.size10,
                        right: Sizes.size10,
                        top: Sizes.size24,
                        bottom: Sizes.size96,
                      ),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        return Text(data.elementAt(index).text);
                      },
                      separatorBuilder: (context, index) => Gaps.v16,
                    );
                  },
                  error: (error, stackTrace) => Center(
                      child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Text(error.toString()),
                        // Text(stackTrace.toString()),
                      ],
                    ),
                  )),
                  loading: () => const Center(
                    child: CircularProgressIndicator.adaptive(),
                  ),
                ),
            CustomBottomTextField(),
          ],
        ),
      ),
    );
  }
}
