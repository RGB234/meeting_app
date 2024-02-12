import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';

class ChatRoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchChatRoomList() async {
    final snapshot = await _db.collection("chat_rooms").get();
    return snapshot.docs;
  }

  Future<void> addChatRoom(ChatRoomModel chatroom) async {
    await _db.collection("chat_rooms").doc().set(chatroom.toJson());
  }
}

final chatRoomRepo = Provider((ref) => ChatRoomRepository());
