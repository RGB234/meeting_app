import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/chat/message_model.dart';

class MessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage({
    required String chatRoomId,
    required MessageModel message,
  }) async {
    await _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .doc()
        .set(message.toJson());
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> loadMessages(chatRoomId) {
    return _db
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .snapshots();
  }
}

final messageRepo = Provider((ref) => MessageRepository());
