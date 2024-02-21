import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/home/models/lobby_model.dart';
import 'package:meeting_app/features/home/repos/lobby_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';

class ChatRoomViewModels extends AutoDisposeAsyncNotifier<List<LobbyModel>> {
  late LobbyRepository _lobbyRepo;

  @override
  FutureOr<List<LobbyModel>> build() async {
    _lobbyRepo = ref.read(lobbyRepo);
    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRoomList;

    // fetch total list
    chatRoomList = await _lobbyRepo.fetchChatRoomList();
    return chatRoomList
        .map((element) => LobbyModel.fromJson(element.data()))
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

    LobbyModel createdChat = LobbyModel.empty();
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
        .read(lobbyRepo)
        .createNewChatRoom(chatroom: createdChat, uid: userId);
    // await ref.read(lobbyRepo).joinThisRoom(uid: uid, roomid: roomid)
    refresh();
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> joinThisRoom({required String roomid}) async {
    ref
        .read(lobbyRepo)
        .joinThisRoom(uid: ref.read(authRepo).user!.uid, roomid: roomid);
  }

  void updateInfo() {}

  void refresh() {
    ref.invalidateSelf();
  }
}

// expose data about the list of all chat rooms
// and methods related to chatrooms (create, delete, change, join, exit...)
final lobbyProvider =
    AsyncNotifierProvider.autoDispose<ChatRoomViewModels, List<LobbyModel>>(
  () => ChatRoomViewModels(),
);

// expose data about the chat room list a user belongs to
final myLobbyProvider =
    StreamProvider.autoDispose.family<List<LobbyModel>, String>(((ref, uid) {
  final LobbyRepository repo = ref.read(lobbyRepo);
  // arg >> user id
  final stream = repo.fetchMyChatRoomList(uid);

  return stream.map((chatRooms) => chatRooms
      .map((chatRoom) => LobbyModel.fromJson(chatRoom.data()!))
      .toList());
}));
