import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/repos/chat_room_repo.dart';

class ChatRoomViewModels extends AsyncNotifier<List<ChatRoomModel>> {
  late ChatRoomRepository _chatRoomRepo;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _chatRoomRepo = ref.read(chatRoomRepo);
    final chatRoomList = await _chatRoomRepo.fetchChatRoomList();
    return chatRoomList
        .map((element) => ChatRoomModel.fronJson(element.data()))
        .toList();
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModels, List<ChatRoomModel>>(
  () => ChatRoomViewModels(),
);
