import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/chat/view_models/message_view_model.dart';
import 'package:meeting_app/features/chat/views/widget/message.dart';
import 'package:meeting_app/features/home/models/room_model.dart';
import 'package:meeting_app/features/home/view_models/lobby_view_model.dart';
import 'package:meeting_app/features/home/view_models/room_view_model.dart';

class ChatScreen extends ConsumerStatefulWidget {
  static const routeName = "chatroom";
  static const routePath = "/chat/:roomID";
  final String roomID;

  const ChatScreen({super.key, required this.roomID});

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
          chatRoomId: widget.roomID,
          text: _textController.text,
        );
    _textController.clear();
  }

  void _exit({required String roomID}) {
    ref.read(lobbyProvider.notifier).exitThisRoom(roomID: roomID);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            ref.watch(roomProvider(widget.roomID)).when(
                data: (data) {
                  return data.title;
                },
                error: (error, stackTrace) => error.toString(),
                loading: () => "..."),
            style: TextStyle(
              // fontFamily: 'Telma',
              fontWeight: FontWeight.w500,
              fontSize: Sizes.size20,
              color: Theme.of(context).primaryColor,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () => {},
              tooltip: "채팅방 설정",
              icon: const Icon(FontAwesomeIcons.screwdriverWrench),
            ),
            IconButton(
              onPressed: () => _exit(roomID: widget.roomID),
              tooltip: "채팅방 나가기",
              icon: const Icon(FontAwesomeIcons.rightFromBracket),
            ),
          ],
        ),
        body: Stack(
          children: [
            ref.watch(messageStreamProvider(widget.roomID)).when(
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
                padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    top: BorderSide(
                      color: Colors.black45,
                      width: 1,
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
                            suffixIcon: IconButton(
                              onPressed: _emptyInput,
                              icon: const Icon(FontAwesomeIcons.xmark),
                              iconSize: Sizes.size20,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                Sizes.size12, Sizes.size12, 0, Sizes.size8),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _sendMessage,
                        icon: const Icon(FontAwesomeIcons.arrowLeft),
                        iconSize: Sizes.size20,
                        color: Theme.of(context).primaryColor,
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
