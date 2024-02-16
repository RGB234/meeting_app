import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/repos/chat_room_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';

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
    required UserProfileModel user,
    // title of a chatroom
    required String title,
    // size of a chatroom
    // ex) female '1' : male '1' --> numOfPairs is '1'
    required int numOfPairs,
    // the time when a new chatroom is created
    required String time,
  }) async {
    final userId = user.uid;
    final userGender = user.gender;
    int numCurrentMale = 0;
    int numCurrentFemale = 0;

    if (userGender == "male") {
      numCurrentMale = 1;
    } else if (userGender == "female") {
      numCurrentFemale = 1;
    }

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
    await ref.read(chatRoomRepo).createNewChatRoom(createdChat);
    refresh();
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> joinThisRoom(
      {required String uid, required String roomid}) async {
    ref.read(chatRoomRepo).joinThisRoom(uid: uid, roomid: roomid);
  }

  void updateInfo() {}

  void refresh() {
    ref.invalidateSelf();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider.autoDispose<ChatRoomViewModels, List<ChatRoomModel>>(
  () => ChatRoomViewModels(),
);
