import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/chat/models/message_model.dart';

class MessageRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> sendMessage({
    required String roomID,
    required MessageModel message,
  }) async {
    final newDocument =
        _db.collection('rooms').doc(roomID).collection('messages').doc();
    await newDocument.set(message.toJson());

    return newDocument.id;
  }

  Future<void> updateMessageInfo(
      {required String roomID,
      required String messageID,
      required MessageModel newMessageInfo}) async {
    await _db
        .collection('rooms')
        .doc(roomID)
        .collection('messages')
        .doc(messageID)
        .update(newMessageInfo.toJson());
  }

  Future<void> deleteMessage(
      {required String roomID, required String messageID}) async {
    await _db
        .collection('rooms')
        .doc(roomID)
        .collection('messages')
        .doc(messageID)
        .update({'deleted': true});
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> loadMessages(chatRoomId) {
    return _db
        .collection('rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy("createdAt")
        .snapshots();
  }
}

final messageRepo = Provider((ref) => MessageRepository());
