class MessageModel {
  final String messageID;
  final String roomID;
  final String createdAt;
  final String createdBy;
  final String text;
  final bool deleted;
  MessageModel({
    required this.messageID,
    required this.roomID,
    required this.createdAt,
    required this.createdBy,
    required this.text,
    this.deleted = false,
  });

  MessageModel.empty()
      : messageID = "",
        roomID = "",
        createdAt = "",
        createdBy = "",
        text = "",
        deleted = false;

  MessageModel.fromJson(Map<String, dynamic> json)
      : messageID = json['messageID'],
        roomID = json['roomID'],
        createdAt = json['createdAt'],
        createdBy = json['createdBy'],
        text = json['text'],
        deleted = json['deleted'];

  Map<String, dynamic> toJson() {
    return {
      'messageID': messageID,
      'roomID': roomID,
      'createdAt': createdAt,
      'createdBy': createdBy,
      'text': text,
      'deleted': deleted,
    };
  }

  MessageModel copyWith({
    String? messageID,
    String? roomID,
    String? createdAt,
    String? createdBy,
    String? text,
    bool? deleted,
  }) {
    return MessageModel(
      messageID: messageID ?? this.messageID,
      roomID: roomID ?? this.roomID,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      text: text ?? this.text,
      deleted: deleted ?? this.deleted,
    );
  }
}
