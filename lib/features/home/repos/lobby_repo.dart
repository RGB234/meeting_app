import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/chat/repos/member_repo.dart';
import 'package:meeting_app/features/home/models/lobby_model.dart';

class LobbyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      fetchChatRoomList() async {
    QuerySnapshot<Map<String, dynamic>> snapshot;
    // fetch total list
    snapshot = await _db
        .collection("rooms")
        .orderBy("createdAt", descending: true)
        .get();

    return snapshot.docs;
  }

  Stream<List<DocumentSnapshot<Map<String, dynamic>>>> fetchMyChatRoomList(
      String uid) async* {
    // ** 중요 : 유저가 참여한 방 목록 (joinedRooms) 에서 삭제된 방이 그대로 남아있으면 오류가 발생
    var stream = _db
        .collection("users")
        .doc(uid)
        .collection("joinedRooms")
        .orderBy("joinedAt", descending: true)
        .snapshots();

    await for (final query in stream) {
      final documents = query.docs;
      final roomIds = documents.map((document) => document.id).toList();
      final chatRooms = await Future.wait(roomIds
          .map((id) async => await _db.collection("rooms").doc(id).get())
          .toList());

      yield chatRooms;
    }
  }

  Future<QuerySnapshot> membersOf({required String roomid}) async {
    return await _db
        .collection('rooms')
        .doc(roomid)
        .collection('members')
        .get();
  }

  Future<void> createNewChatRoom(
      {required String uid, required LobbyModel chatroom}) async {
    final newDocument = _db.collection("rooms").doc();
    // add id field
    chatroom = chatroom.copyWith(id: newDocument.id);

    await newDocument.set(chatroom.toJson());
    joinThisRoom(uid: uid, roomid: newDocument.id);
  }

  // update user's joined rooms list & chat_room's joined_users list
  Future<void> joinThisRoom(
      {required String uid, required String roomid}) async {
    MemberRepository memberRepo = MemberRepository();
    late Map<String, dynamic> json;

    late List<int> counts;

    final now = DateTime.now();
    final joinedAt =
        "${now.year}:${now.month}:${now.day}:${now.hour}:${now.minute}";

    // update chat_room
    await _db
        .collection("rooms")
        .doc(roomid)
        .collection("members")
        .doc(uid)
        .set({"joinedAt": joinedAt});

    counts = await memberRepo.countMembers(roomid: roomid);

    json = {
      'numCurrentMale': counts[0],
      'numCurrentFemale': counts[1],
    };

    updateRoomInfo(roomid, json);

    // user 가 참가한 방 목록을 Stream 으로 전달받는중
    // 따라서 user의 참가한 방 목록에 추가하고 난 후, db 에 저장되는 채팅방의 필드값 (인원수, 제목) 등을 변경하면
    // 변경사항이 적용이 안된 채로 chat_screen 에 Stream 이 전달된다
    // update user
    await _db
        .collection("users")
        .doc(uid)
        .collection("joinedRooms")
        .doc(roomid)
        .set({"joinedAt": joinedAt});
  }

  Future<void> updateRoomInfo(String roomid, Map<String, dynamic> json) async {
    await _db.collection('rooms').doc(roomid).update(json);
  }
}

final lobbyRepo = Provider((ref) => LobbyRepository());
