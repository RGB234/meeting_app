import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/home/models/room_model.dart';
import 'package:meeting_app/features/home/models/users_rooms_model.dart';
import 'package:meeting_app/features/home/repos/lobby_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';

class LobbyViewModel extends AutoDisposeAsyncNotifier<List<RoomModel>> {
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
    final String time = now.toString();

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

    await enterThisRoom(roomID: createdRoomId, authority: "host");

    refresh();
  }

  Future<void> enterThisRoom({
    required String roomID,
    String authority = "guest",
  }) async {
    final uid = ref.read(authRepo).user!.uid;
    final exist = await _lobbyRepo.findUserInThisRoom(uid: uid, roomID: roomID);
    // -- user already exits in this room --
    if (exist) {
      return;
    }

    // -- user entered this room as a new member --
    final DateTime now = DateTime.now();
    final String time = now.toString();

    final updateInfo = UsersRoomsModel(
        uid: uid, roomID: roomID, joinedAt: time, authority: authority);

    await _lobbyRepo.enterThisRoom(updateInfo);

    // -- update count of Male/Female --
    final roomInfo = await _lobbyRepo.getRoomInfo(roomID);

    final snapshot = await ref.read(userRepo).findUserById(uid);
    // user is already login-state. can't be null
    final user = UserProfileModel.fromJson(snapshot.data()!);

    Map<String, dynamic> json;
    if (user.gender == 'male') {
      json = {
        'numCurrentMale': roomInfo.numCurrentMale + 1,
      };
    } else if (user.gender == 'femlae') {
      json = {
        'numCurrentFemale': roomInfo.numCurrentFemale + 1,
      };
    } else {
      json = {
        'numCurrentFemale': roomInfo.numCurrentFemale + 1,
      };
    }

    await ref.read(lobbyRepo).updateRoomInfo(roomID, json);

    ref.invalidate(myLobbyProvider);
  }

  void updateInfo() {}

  void refresh() {
    ref.invalidateSelf();
  }
}

class MyLobbyViewModel
    extends AutoDisposeFamilyAsyncNotifier<List<RoomModel>, String> {
  late LobbyRepository _lobbyRepo;
  @override
  FutureOr<List<RoomModel>> build(String arg) async {
    _lobbyRepo = ref.read(lobbyRepo);
    // arg >> user id
    final myChatRooms = await _lobbyRepo.fetchMyChatRoomList(arg);

    return myChatRooms
        .map((chatroom) => RoomModel.fromJson(chatroom.data()!))
        .toList();
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

// expose data about the list of all chat rooms
// and methods related to chatrooms (create, delete, change, join, exit...)
final lobbyProvider =
    AsyncNotifierProvider.autoDispose<LobbyViewModel, List<RoomModel>>(
  () => LobbyViewModel(),
);

final myLobbyProvider = AsyncNotifierProvider.autoDispose
    .family<MyLobbyViewModel, List<RoomModel>, String>(
  () => MyLobbyViewModel(),
);
