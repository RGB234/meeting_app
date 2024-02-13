import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/view_models/chat_room_view_model.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ExploreScreenState();
}

enum NumOfPairs {
  one,
  two,
  three,
  four,
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  Future<void> _showChatRoomPopup() {
    NumOfPairs? pairs = NumOfPairs.one;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog.adaptive(
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("취소")),
                    OutlinedButton(onPressed: () {}, child: const Text("생성")),
                  ],
                )
              ],
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "채팅방 제목",
                      style: TextStyle(
                        fontSize: Sizes.size16,
                      ),
                    ),
                    const TextField(
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(hintText: "title"),
                    ),
                    Gaps.v28,
                    Column(
                      children: [
                        const Text(
                          "채팅방 인원",
                          style: TextStyle(
                            fontSize: Sizes.size16,
                          ),
                        ),
                        RadioListTile(
                          title: const Text("1:1"),
                          value: NumOfPairs.one,
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("2:2"),
                          value: NumOfPairs.two,
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("3:3"),
                          value: NumOfPairs.three,
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("4:4"),
                          value: NumOfPairs.four,
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        Text(pairs.toString()),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _refreshList() {
    ref.read(chatRoomProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
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
            ),
        Positioned(
          right: MediaQuery.of(context).padding.right,
          bottom: MediaQuery.of(context).padding.bottom + Sizes.size16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () {
                  _refreshList();
                },
                icon: const Icon(Icons.refresh_outlined),
                iconSize: Sizes.size28,
              ),
              IconButton(
                onPressed: () {
                  _showChatRoomPopup();
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
                iconSize: Sizes.size28,
              ),
            ],
          ),
        ),
      ],
    );
  }
}