import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/repos/chat_room_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';

class ChatRoomViewModels extends AutoDisposeAsyncNotifier<List<ChatRoomModel>> {
  late ChatRoomRepository _chatRoomRepo;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _chatRoomRepo = ref.read(chatRoomRepo);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRoomList;

    // fetch total list
    chatRoomList = await _chatRoomRepo.fetchChatRoomList();
    return chatRoomList
        .map((element) => ChatRoomModel.fromJson(element.data()))
        .toList();
  }

  Future<void> createNewChatRoom({
    // title of a chatroom
    required String title,
    // size of a chatroom
    // ex) female '1' : male '1' --> numOfPairs is '1'
    required int numOfPairs,
  }) async {
    final UserProfileModel user = ref.read(userProvider).value!;
    final DateTime now = DateTime.now();
    final String time =
        "${now.year}:${now.month}:${now.day}:${now.hour}:${now.minute}";

    final userId = user.uid;
    int numCurrentMale = 0;
    int numCurrentFemale = 0;

    ChatRoomModel createdChat = ChatRoomModel.empty();
    createdChat = createdChat.copyWith(
      title: title,
      numMaxMale: numOfPairs,
      numMaxFemale: numOfPairs,
      numCurrentMale: numCurrentMale,
      numCurrentFemale: numCurrentFemale,
      createdAt: time,
      createdBy: userId,
    );
    await ref
        .read(chatRoomRepo)
        .createNewChatRoom(chatroom: createdChat, uid: userId);
    // await ref.read(chatRoomRepo).joinThisRoom(uid: uid, roomid: roomid)
    refresh();
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> joinThisRoom({required String roomid}) async {
    ref
        .read(chatRoomRepo)
        .joinThisRoom(uid: ref.read(authRepo).user!.uid, roomid: roomid);
  }

  void updateInfo() {}

  void refresh() {
    ref.invalidateSelf();
  }
}

// expose data about the list of all chat rooms
// and methods related to chatrooms (create, delete, change, join, exit...)
final chatRoomProvider =
    AsyncNotifierProvider.autoDispose<ChatRoomViewModels, List<ChatRoomModel>>(
  () => ChatRoomViewModels(),
);

// expose data about the chat room list a user belongs to
final myChatRoomProvider =
    StreamProvider.autoDispose.family<List<ChatRoomModel>, String>(((ref, arg) {
  final ChatRoomRepository repo = ref.read(chatRoomRepo);
  // arg >> user id
  final stream = repo.fetchMyChatRoomList(arg);

  return stream.map((chatRooms) => chatRooms
      .map((chatRoom) => ChatRoomModel.fromJson(chatRoom.data()!))
      .toList());
}));
