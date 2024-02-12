import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/repos/chat_room_repo.dart';

class ChatRoomViewModels extends AsyncNotifier<List<ChatRoomModel>> {
  late final ChatRoomRepository _chatRoomRepo;

  @override
  FutureOr<List<ChatRoomModel>> build() async {
    _chatRoomRepo = ref.read(chatRoomRepo);
    final chatRoomList = await _chatRoomRepo.fetchChatRoomList();
    return chatRoomList.map((element) {
      print(">>");
      print(element.data());
      return ChatRoomModel.fronJson(element.data());
    }).toList();
  }
}

final chatRoomProvider =
    AsyncNotifierProvider<ChatRoomViewModels, List<ChatRoomModel>>(
  () => ChatRoomViewModels(),
);
