import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';

class ChatRoomRepository {
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

  Future<List<Future<DocumentSnapshot<Map<String, dynamic>>>>>
      fetchMyChatRoomList(String uid) async {
    final listOfRoomId = await _db
        .collection("users")
        .doc(uid)
        .collection("joinedRooms")
        .orderBy("joinedAt", descending: true)
        .get();

    final processedList = listOfRoomId.docs.map((e) async {
      final reference = _db.collection("chat_rooms").doc(e.id);
      final record = await reference.get();
      return record;
    }).toList();

    return processedList;
  }

  Future<void> createNewChatRoom(ChatRoomModel chatroom) async {
    // await _db.collection("chat_rooms").doc().set(chatroom.toJson());
    final newDocument = _db.collection("chat_rooms").doc();
    // add id field
    chatroom = chatroom.copyWith(id: newDocument.id);

    await newDocument.set(chatroom.toJson());
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

final chatRoomRepo = Provider((ref) => ChatRoomRepository());
