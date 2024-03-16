import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/chat/models/message_model.dart';
import 'package:meeting_app/features/chat/repos/message_repo.dart';

class MessageViewModel extends AsyncNotifier<void> {
  late MessageRepository _messageRepo;
  @override
  FutureOr build() {
    _messageRepo = ref.read(messageRepo);
  }

  Future<void> sendMessage({
    required final String chatRoomId,
    required final String text,
  }) async {
    state = const AsyncValue.loading();

    DateTime datetimeNow = DateTime.now();
    final now = datetimeNow.toString();

    final senderUid = ref.read(authRepo).user!.uid;

    state = await AsyncValue.guard(() async {
      final message = MessageModel.fromJson({
        // messageID should be updated after _messageRepo.sendMessage
        'messageID': "",
        'roomID': chatRoomId,
        'createdAt': now,
        'createdBy': senderUid,
        'text': text,
        'deleted': false,
      });
      final messageID =
          await _messageRepo.sendMessage(roomID: chatRoomId, message: message);

      // update messageID field
      final msg = message.copyWith(messageID: messageID);

      await _messageRepo.updateMessageInfo(
          roomID: chatRoomId, messageID: messageID, newMessageInfo: msg);
    });
  }

  Future<void> deleteMessage({required chatRoomID, required messageID}) async {
    await _messageRepo.deleteMessage(roomID: chatRoomID, messageID: messageID);
  }
}

final messageProvider = AsyncNotifierProvider<MessageViewModel, void>(
  () => MessageViewModel(),
);

final messageStreamProvider = StreamProvider.autoDispose
    .family<List<MessageModel>, String>((ref, chatRoomId) {
  final streamOfMessages = ref.read(messageRepo).loadMessages(chatRoomId);

  return streamOfMessages.map((event) => event.docs
      .map((element) => MessageModel.fromJson(element.data()))
      .toList());
});
