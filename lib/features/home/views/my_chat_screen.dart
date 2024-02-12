import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/features/home/view_models/chat_room_view_model.dart';

class MyChatScreen extends ConsumerStatefulWidget {
  const MyChatScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyChatScreenState();
}

class _MyChatScreenState extends ConsumerState<MyChatScreen> {
  Future<void> _addChatRoom() async {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {
                _addChatRoom();
              },
              icon: const FaIcon(FontAwesomeIcons.plus),
            ),
          ],
        ),
        ref.watch(chatRoomProvider).when(
              data: (data) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return Text(data.elementAt(index).subtitle.toString());
                  },
                  separatorBuilder: (context, index) {
                    return Gaps.v12;
                  },
                  itemCount: data.length,
                );
              },
              error: (error, stackTrace) => Center(
                child: Text(error.toString()),
              ),
              loading: () => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
      ],
    );
  }
}
