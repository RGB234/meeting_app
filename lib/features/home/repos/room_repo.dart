import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/home/models/room_model.dart';

class RoomRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<RoomModel> getRoomInfo(String roomID) async {
    final room = await _db.collection('rooms').doc(roomID).get();
    if (room.data() == null) {
      return RoomModel.empty();
    }

    return RoomModel.fromJson(room.data()!);
  }
}

final roomRepo = Provider((ref) => RoomRepository());
