import "package:flutter/material.dart";
import "package:go_router/go_router.dart";
import "package:meeting_app/constants/gaps.dart";
import "package:meeting_app/features/chat/chat_screen.dart";

class SingleGroupChat extends StatelessWidget {
  final String text;
  final String chatId;

  const SingleGroupChat({
    super.key,
    required this.text,
    required this.chatId,
  });

  void _enterThisRoom(BuildContext context) {
    context.pushNamed(
      ChatScreen.routeName,
      pathParameters: {'chatId': chatId},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _enterThisRoom(context),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 26,
            backgroundImage: NetworkImage(
                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTn5652UtfUdYwTHiiL_2_YtvypxsIxTSiVwg&usqp=CAU"),
          ),
          Gaps.h12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Male : 4/4",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  "Female : 2/4",
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
                Gaps.v12,
                Text(text),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GroupChats extends StatelessWidget {
  const GroupChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => SingleGroupChat(
        text: "햄스터랑 지구정복할 사람구해요. 고양이 정중히 사절🙏 자세한 문의 DM 부탁드려요🙏",
        chatId: "$index",
      ),
      separatorBuilder: (context, index) => Gaps.v48,
      itemCount: 7,
      scrollDirection: Axis.vertical,
    );
  }
}
