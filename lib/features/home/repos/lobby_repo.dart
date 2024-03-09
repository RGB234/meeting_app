import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/room_model.dart';
import 'package:meeting_app/features/home/models/users_rooms_model.dart';

class LobbyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchChatRoomList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    // fetch total list
    snapshot = await _db
        .collection("rooms")
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs;
  }

  Future<List<DocumentSnapshot<Map<String, dynamic>>>> fetchMyChatRoomList(
      String uid) async {
    final data = await _db
        .collection('users_rooms')
        .orderBy('joinedAt', descending: true)
        .get();

    List<String> roomIDs = [];
    for (final row in data.docs) {
      if (row.data()['uid'] == uid) {
        roomIDs.add(row.data()['roomID']);
      }
    }
    final chatRooms = await Future.wait(roomIDs
        .map((id) async => await _db.collection("rooms").doc(id).get())
        .toList());

    return chatRooms;
  }

  Future<String> createNewChatRoom({
    required String uid,
    required RoomModel chatroom,
  }) async {
    final newDocument = _db.collection("rooms").doc();
    // add id field
    chatroom = chatroom.copyWith(roomID: newDocument.id);

    await newDocument.set(chatroom.toJson());

    return newDocument.id;
  }

  Future<bool> findUserInThisRoom(
      {required String uid, required String roomID}) async {
    final rows = await _db.collection('users_rooms').get();
    for (final row in rows.docs) {
      if (row.data()['roomID'] == roomID && row.data()['uid'] == uid) {
        return true;
      }
    }
    return false;
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> enterThisRoom(UsersRoomsModel updateInfo) async {
    // -- new member --
    // update users_rooms table
    await _db.collection("users_rooms").doc().set(updateInfo.toJson());
  }

  Future<void> updateRoomInfo(String roomID, Map<String, dynamic> json) async {
    await _db.collection('rooms').doc(roomID).update(json);
  }

  Future<RoomModel> getRoomInfo(String roomID) async {
    final room = await _db.collection('rooms').doc(roomID).get();
    if (room.data() == null) {
      return RoomModel.empty();
    }

    return RoomModel.fromJson(room.data()!);
  }
}

final lobbyRepo = Provider((ref) => LobbyRepository());
