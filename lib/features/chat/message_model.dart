class MessageModel {
  final String createdAt;
  final String createdBy;
  final String text;
  MessageModel({
    required this.createdAt,
    required this.createdBy,
    required this.text,
  });

  MessageModel.empty()
      : createdAt = "",
        createdBy = "",
        text = "";

  MessageModel.fromJson(Map<String, dynamic> json)
      : createdAt = json['createdAt'],
        createdBy = json['createdBy'],
        text = json['text'];

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt,
      'createdBy': createdBy,
      'text': text,
    };
  }

  MessageModel copyWith({
    String? createdAt,
    String? createdBy,
    String? text,
  }) {
    return MessageModel(
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      text: text ?? this.text,
    );
  }
}
