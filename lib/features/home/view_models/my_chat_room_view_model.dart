import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/chat_room_model.dart';
import 'package:meeting_app/features/home/repos/chat_room_repo.dart';

class MyChatRoomViewModel
    extends FamilyAsyncNotifier<List<ChatRoomModel>, String> {
  late ChatRoomRepository _chatRoomRepo;
  @override
  FutureOr<List<ChatRoomModel>> build(String uid) async {
    _chatRoomRepo = ref.read(chatRoomRepo);

    // fetch list of a user
    Future.delayed(Duration(seconds: 3));
    final chatRoomList = await _chatRoomRepo.fetchMyChatRoomList(uid);
    final resultList = await Future.wait(chatRoomList.map((element) async {
      final json = await element.then((value) => value.data()!);
      return ChatRoomModel.fromJson(json);
    }).toList());
    return resultList;
  }

  void refresh() {
    ref.invalidateSelf();
  }
}

final myChatRoomProvider = AsyncNotifierProvider.family<MyChatRoomViewModel,
    List<ChatRoomModel>, String>(() => MyChatRoomViewModel());
