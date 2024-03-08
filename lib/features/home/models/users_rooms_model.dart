class UsersRoomsModel {
  // users_rooms mapping table Model
  final String uid;
  final String roomID;
  final String authority;
  final String joinedAt;

  UsersRoomsModel({
    required this.uid,
    required this.roomID,
    this.authority = "guest",
    required this.joinedAt,
  });

  UsersRoomsModel.empty()
      : uid = "",
        roomID = "",
        authority = "guest",
        joinedAt = "";

  UsersRoomsModel.fromJson(Map<String, dynamic> json)
      : uid = json['uid'],
        roomID = json['roomID'],
        authority = json['authority'],
        joinedAt = json['joinedAt'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'roomID': roomID,
      'authority': authority,
      'joinedAt': joinedAt,
    };
  }

  UsersRoomsModel copyWith({
    String? uid,
    String? roomID,
    String? authority,
    String? joinedAt,
  }) {
    return UsersRoomsModel(
      uid: uid ?? this.uid,
      roomID: roomID ?? this.roomID,
      joinedAt: joinedAt ?? this.joinedAt,
    );
  }
}
