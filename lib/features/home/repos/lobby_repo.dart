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

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> fetchMyChatRoomList(
      String uid) async* {
    // ** 중요 : 유저가 참여한 방 목록 (joinedRooms) 에서 삭제된 방이 그대로 남아있으면 오류가 발생

    // var stream = _db
    //     .collection("users")
    //     .doc(uid)
    //     .collection("joinedRooms")
    //     .orderBy("joinedAt", descending: true)
    //     .snapshots();

    // await for (final query in stream) {
    //   final documents = query.docs;
    //   final roomIds = documents.map((document) => document.id).toList();
    //   final chatRooms = await Future.wait(roomIds
    //       .map((id) async => await _db.collection("rooms").doc(id).get())
    //       .toList());

    //   yield chatRooms;
    // }

    final snapshots = _db.collection('users_rooms').snapshots();
    await for (final snapshot in snapshots) {
      final roomIds = snapshot.docs.map((element) {
        if (element.data()['uid'] == uid) return element.data()['roomID'];
      }).toList();

      final chatRooms = await Future.wait(roomIds
          .map((id) async => await _db.collection("rooms").doc(id).get())
          .toList());

      yield chatRooms;
    }
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

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> enterThisRoom(UsersRoomsModel updateInfo) async {
    // MemberRepository memberRepo = MemberRepository();
    final roomID = updateInfo.roomID;
    late Map<String, dynamic> json;

    late List<int> count;

    // update users_rooms table
    await _db.collection("users_rooms").doc().set(updateInfo.toJson());

    // update count of members
    // count = await memberRepo.countMembers(roomID: roomID);
    count = [0, 0];

    json = {
      'numCurrentMale': count[0],
      'numCurrentFemale': count[1],
    };

    updateRoomInfo(roomID, json);
  }

  Future<void> updateRoomInfo(String roomid, Map<String, dynamic> json) async {
    await _db.collection('rooms').doc(roomid).update(json);
  }
}

final lobbyRepo = Provider((ref) => LobbyRepository());
