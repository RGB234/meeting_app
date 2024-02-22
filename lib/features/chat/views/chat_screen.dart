import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/chat/view_models/message_view_model.dart';
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
  final TextEditingController _textController = TextEditingController();

  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  void _emptyInput() {
    _textController.clear();
  }

  void _sendMessage() {
    ref.read(messageProvider.notifier).sendMessage(
          chatRoomId: widget.chatId,
          text: _textController.text,
        );
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
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
                        return Message(
                          message: data.elementAt(index),
                          isMyMessage: data.elementAt(index).createdBy ==
                              ref.read(authRepo).user!.uid,
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v48,
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
            // TextField
            Positioned(
              width: screenSize.width,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                      width: 0.5,
                    ),
                  ),
                ),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          clipBehavior: Clip.hardEdge,
                          keyboardType: TextInputType.multiline,
                          controller: _textController,
                          // expands: true,
                          // minLines: null,
                          maxLines: null,
                          textInputAction: TextInputAction.newline,
                          style: const TextStyle(
                            fontSize: Sizes.size16,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: Sizes.size4,
                              horizontal: Sizes.size10,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _emptyInput,
                        icon: const Icon(FontAwesomeIcons.xmark),
                      ),
                      IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(FontAwesomeIcons.arrowLeft),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
