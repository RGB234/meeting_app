import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/chat/models/message_model.dart';
import 'package:meeting_app/features/chat/view_models/message_view_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';

class Message extends ConsumerStatefulWidget {
  final bool isMyMessage;
  final bool isDeleted;
  final MessageModel message;

  const Message({
    super.key,
    required this.message,
    this.isDeleted = false,
    this.isMyMessage = false,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MessageState();
}

class _MessageState extends ConsumerState<Message> {
  Future<void> _deleteMessage(
      {required String chatRoomID, required String messageID}) async {
    ref
        .read(messageProvider.notifier)
        .deleteMessage(chatRoomID: chatRoomID, messageID: messageID);
  }

  @override
  Widget build(BuildContext context) {
    final messageBoxWidth = MediaQuery.of(context).size.width * 0.6;
    // userProviderByID 는 autoDispose 옵션으로 인해 채팅방을 나갔다 오면 새로고침됨.
    // 그 전까지는 유저의 이름 변경 등, 변경사항이 실시간으로 적용되지 않는다.
    // db 에 Stream 을 연결하지 않는 이상, db 상에서 다른 유저의 프로필이 변경됨을 감지하기가 불가능하기 때문
    // Stream 연결로 인한 리소스 사용량 대비 실시간으로 유저의 프로필 변경을 반영해야 할 필요성도 적기에 일부러 냅뒀다.

    return ref.watch(userProviderById(widget.message.createdBy)).when(
          data: (sender) {
            return widget.isMyMessage
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: messageBoxWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(sender.username),
                            Gaps.v8,
                            GestureDetector(
                              onLongPress: () {
                                if (!widget.isDeleted) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(
                                              Sizes.size10),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const Text("메시지를 삭제하시겠습니까?"),
                                              Gaps.v12,
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        _deleteMessage(
                                                            chatRoomID: widget
                                                                .message.roomID,
                                                            messageID: widget
                                                                .message
                                                                .messageID);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: const Text("예")),
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.of(context)
                                                              .pop(),
                                                      child: const Text("아니요")),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(Sizes.size10),
                                  child: widget.isDeleted
                                      ? const Text(
                                          "삭제된 메시지입니다",
                                          style:
                                              TextStyle(color: Colors.black54),
                                        )
                                      : Text(
                                          widget.message.text,
                                        ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Gaps.h12,
                      CircleAvatar(
                        radius: Sizes.size20,
                        backgroundImage: NetworkImage(sender.photoURL ??
                            "https://media.bunjang.co.kr/images/crop/352154106_w%7Bres%7D.jpg"),
                      ),
                    ],
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: Sizes.size20,
                        backgroundImage: NetworkImage(sender.photoURL ??
                            "https://media.bunjang.co.kr/images/crop/352154106_w%7Bres%7D.jpg"),
                      ),
                      Gaps.h12,
                      SizedBox(
                        width: messageBoxWidth,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(sender.username),
                            Gaps.v8,
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(Sizes.size10),
                                child: widget.isDeleted
                                    ? const Text(
                                        "삭제된 메시지입니다",
                                        style: TextStyle(color: Colors.black54),
                                      )
                                    : Text(
                                        widget.message.text,
                                      ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  );
          },
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        );
  }
}
