import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/chat/message_model.dart';
import 'package:meeting_app/features/chat/repos/message_repo.dart';
import 'package:meeting_app/utils.dart';

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

    final now = DateTimeFormatUtil.nowYtoM;
    final currentUserId = ref.read(authRepo).user!.uid;

    AsyncValue.guard(() async {
      final message = MessageModel.fromJson({
        'createdAt': now,
        'createdBy': currentUserId,
        'text': text,
      });
      _messageRepo.sendMessage(chatRoomId: chatRoomId, message: message);
    });
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
