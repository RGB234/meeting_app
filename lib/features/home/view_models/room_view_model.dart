import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/room_model.dart';
import 'package:meeting_app/features/home/repos/room_repo.dart';

class RoomViewModel extends AutoDisposeFamilyAsyncNotifier<RoomModel, String> {
  late RoomRepository _roomRepo;
  @override
  FutureOr<RoomModel> build(String arg) async {
    _roomRepo = ref.read(roomRepo);

    return await _roomRepo.getRoomInfo(arg);
  }
}

final roomProvider =
    AutoDisposeAsyncNotifierProvider.family<RoomViewModel, RoomModel, String>(
  () => RoomViewModel(),
);
