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
                    // return Text(data.elementAt(index).subtitle);
                    return GestureDetector(
                      onTap: () => {},
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
                                  "Male : ${data.elementAt(index).numCurrentMale}/${data.elementAt(index).numMaxMale}",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Text(
                                  "Female : ${data.elementAt(index).numCurrentFemale}/${data.elementAt(index).numMaxFemale}",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                                Gaps.v12,
                                Text(data.elementAt(index).title),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
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
              loading: () => const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            )
      ],
    );
  }
}
