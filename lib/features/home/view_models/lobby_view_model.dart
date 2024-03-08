import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/home/models/room_model.dart';
import 'package:meeting_app/features/home/models/users_rooms_model.dart';
import 'package:meeting_app/features/home/repos/lobby_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';

class LobbyViewModels extends AutoDisposeAsyncNotifier<List<RoomModel>> {
  late LobbyRepository _lobbyRepo;

  @override
  FutureOr<List<RoomModel>> build() async {
    _lobbyRepo = ref.read(lobbyRepo);

    List<QueryDocumentSnapshot<Map<String, dynamic>>> chatRoomList;

    // fetch total list
    chatRoomList = await _lobbyRepo.fetchChatRoomList();
    return chatRoomList
        .map((element) => RoomModel.fromJson(element.data()))
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

    RoomModel chatroom = RoomModel.empty();
    chatroom = chatroom.copyWith(
      title: title,
      numMaxMale: numOfPairs,
      numMaxFemale: numOfPairs,
      numCurrentMale: numCurrentMale,
      numCurrentFemale: numCurrentFemale,
      createdAt: time,
      hostID: userId,
    );

    final createdRoomId = await ref
        .read(lobbyRepo)
        .createNewChatRoom(chatroom: chatroom, uid: userId);

    await enterThisRoom(roomID: createdRoomId);

    refresh();
  }

  Future<void> enterThisRoom({required String roomID}) async {
    final DateTime now = DateTime.now();
    final String time =
        "${now.year}:${now.month}:${now.day}:${now.hour}:${now.minute}";

    final uid = ref.read(authRepo).user!.uid;

    // users_rooms_model
    final updateInfo =
        UsersRoomsModel(uid: uid, roomID: roomID, joinedAt: time);

    await ref.read(lobbyRepo).enterThisRoom(updateInfo);
  }

  void updateInfo() {}

  void refresh() {
    ref.invalidateSelf();
  }
}

// expose data about the list of all chat rooms
// and methods related to chatrooms (create, delete, change, join, exit...)
final lobbyProvider =
    AsyncNotifierProvider.autoDispose<LobbyViewModels, List<RoomModel>>(
  () => LobbyViewModels(),
);

// expose data about the chat room list a user belongs to
final myLobbyProvider =
    StreamProvider.autoDispose.family<List<RoomModel>, String>(((ref, uid) {
  final LobbyRepository repo = ref.read(lobbyRepo);
  // arg >> user id
  final stream = repo.fetchMyChatRoomList(uid);

  return stream.map((chatRooms) => chatRooms
      .map((chatRoom) => RoomModel.fromJson(chatRoom.data()!))
      .toList());
}));
