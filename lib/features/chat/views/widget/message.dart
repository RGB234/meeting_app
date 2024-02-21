import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';

class Message extends StatefulWidget {
  final bool isMyMessage;
  const Message({
    super.key,
    this.isMyMessage = false,
  });

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    final messageBoxWidth = MediaQuery.of(context).size.width * 0.6;
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
                    const Text("깡햄쮜"),
                    Gaps.v8,
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(Sizes.size10),
                        child: Text(
                          "언젠가 우리 함께 듣던 그 멜로디 듣자마자 떠올라 그 때의 메모리즈 All of my old school lovers where you at 이 노래 듣고 같은 느낌 느끼길 바래",
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Gaps.h12,
              const CircleAvatar(
                radius: Sizes.size20,
                backgroundImage: NetworkImage(
                    "https://media.bunjang.co.kr/images/crop/352154106_w%7Bres%7D.jpg"),
              ),
            ],
          )
        : Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: Sizes.size20,
                backgroundImage: NetworkImage(
                    "https://media.bunjang.co.kr/images/crop/352154106_w%7Bres%7D.jpg"),
              ),
              Gaps.h12,
              SizedBox(
                width: messageBoxWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("갱얼쥐"),
                    Gaps.v8,
                    Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(Sizes.size10),
                        child: Text(
                          "언젠가 우리 함께 듣던 그 멜로디 듣자마자 떠올라 그 때의 메모리즈 All of my old school lovers where you at 이 노래 듣고 같은 느낌 느끼길 바래",
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
  }
}
