import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/home/view_models/lobby_view_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';
import 'package:meeting_app/utils.dart';

class MyChatListScreen extends ConsumerStatefulWidget {
  const MyChatListScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MyChatListScreenState();
}

class _MyChatListScreenState extends ConsumerState<MyChatListScreen> {
  final TextEditingController _controller = TextEditingController();
  List<int> numOfPairsOption = [1, 2, 3, 4];
  int? pairs = 4;

  Future<void> _showChatRoomPopup({required String uid}) {
    // ensure userProvider.value is not null because _addChatRoom() will use that
    ref.read(userProvider);
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
                      child: const Text("취소"),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        _addChatRoom(
                          uid: uid,
                          title: _controller.value.text,
                          numOfPairs: pairs ?? 4,
                        );
                      },
                      child: const Text("생성"),
                    ),
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
                    TextField(
                      controller: _controller,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(hintText: "title"),
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
                          value: numOfPairsOption[0],
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("2:2"),
                          value: numOfPairsOption[1],
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("3:3"),
                          value: numOfPairsOption[2],
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
                        RadioListTile(
                          title: const Text("4:4"),
                          value: numOfPairsOption[3],
                          groupValue: pairs,
                          onChanged: (value) {
                            setState(() {
                              pairs = value;
                            });
                          },
                        ),
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

  void _addChatRoom(
      {required String uid, required String title, required int numOfPairs}) {
    ref.read(lobbyProvider.notifier).createNewChatRoom(
          title: title,
          numOfPairs: numOfPairs,
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final isSignedIn = ref.watch(authRepo).isSignedIn;
    // only signed-in user can access to this screen
    final user = ref.watch(authRepo).user;

    if (user == null) {
      return const Center(
        child: Text("로그인이 필요한 서비스입니다."),
      );
    }

    final currentUserid = ref.watch(authRepo).user!.uid;

    return Stack(
      children: [
        ref.watch(myLobbyProvider(currentUserid)).when(
              data: (data) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        if (!isSignedIn) {
                          showErrorSnack(context, "로그인이 필요한 서비스입니다.");
                          return;
                        }
                      },
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
                    return Gaps.v24;
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
                  _showChatRoomPopup(uid: currentUserid);
                },
                icon: const Icon(Icons.add_circle_outline_rounded),
                iconSize: Sizes.size28,
              )
            ],
          ),
        )
      ],
    );
  }
}
