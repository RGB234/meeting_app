import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/lobby_model.dart';

class LobbyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchChatRoomList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    // fetch total list
    snapshot = await _db
        .collection("chat_rooms")
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs;
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> fetchMyChatRoomList(
      String uid) async* {
    // ** 중요 : 유저가 참여한 방 목록 (joinedRooms) 에서 삭제된 방이 그대로 남아있으면 오류가 발생
    var stream = _db
        .collection("users")
        .doc(uid)
        .collection("joinedRooms")
        .orderBy("joinedAt", descending: true)
        .snapshots();

    await for (final query in stream) {
      final documents = query.docs;
      final roomIds = documents.map((document) => document.id).toList();
      final chatRooms = await Future.wait(roomIds
          .map((id) async => await _db.collection("chat_rooms").doc(id).get())
          .toList());

      yield chatRooms;
    }
  }

  Future<void> createNewChatRoom(
      {required String uid, required LobbyModel chatroom}) async {
    final newDocument = _db.collection("chat_rooms").doc();
    // add id field
    chatroom = chatroom.copyWith(id: newDocument.id);

    await newDocument.set(chatroom.toJson());
    joinThisRoom(uid: uid, roomid: newDocument.id);
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> joinThisRoom(
      {required String uid, required String roomid}) async {
    final now = DateTime.now();
    final joinedAt =
        "${now.year}:${now.month}:${now.day}:${now.hour}:${now.minute}";

    // update user
    await _db
        .collection("users")
        .doc(uid)
        .collection("joinedRooms")
        .doc(roomid)
        .set({"joinedAt": joinedAt});

    // update chat_room
    await _db
        .collection("chat_rooms")
        .doc(roomid)
        .collection("joinedUsers")
        .doc(uid)
        .set({"joinedAt": joinedAt});
  }
}

final lobbyRepo = Provider((ref) => LobbyRepository());
