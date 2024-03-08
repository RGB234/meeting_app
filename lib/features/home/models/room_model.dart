class RoomModel {
  final String roomID;
  final String image;
  final int numCurrentFemale;
  final int numCurrentMale;
  final int numMaxFemale;
  final int numMaxMale;
  final String title;
  final String createdAt;
  final String hostID;

  RoomModel({
    required this.roomID,
    required this.image,
    required this.numCurrentFemale,
    required this.numCurrentMale,
    required this.numMaxFemale,
    required this.numMaxMale,
    required this.title,
    required this.createdAt,
    required this.hostID,
  });

  RoomModel.empty()
      : roomID = "",
        image = "",
        numCurrentFemale = 0,
        numCurrentMale = 0,
        numMaxFemale = 4,
        numMaxMale = 4,
        title = "",
        createdAt = "",
        hostID = "";

  RoomModel.fromJson(Map<String, dynamic> json)
      : roomID = json["roomID"],
        image = json["image"],
        numCurrentFemale = json["numCurrentFemale"],
        numCurrentMale = json["numCurrentMale"],
        numMaxFemale = json["numMaxFemale"],
        numMaxMale = json["numMaxMale"],
        title = json["title"],
        createdAt = json["createdAt"],
        hostID = json["hostID"];

  Map<String, dynamic> toJson() {
    return {
      "roomID": roomID,
      "image": image,
      "numCurrentFemale": numCurrentFemale,
      "numCurrentMale": numCurrentMale,
      "numMaxFemale": numMaxFemale,
      "numMaxMale": numMaxMale,
      "title": title,
      "createdAt": createdAt,
      "hostID": hostID,
    };
  }

  RoomModel copyWith({
    String? roomID,
    String? image,
    int? numCurrentFemale,
    int? numCurrentMale,
    int? numMaxFemale,
    int? numMaxMale,
    String? subtitle,
    String? title,
    String? createdAt,
    String? hostID,
  }) {
    return RoomModel(
      roomID: roomID ?? this.roomID,
      image: image ?? this.image,
      numCurrentFemale: numCurrentFemale ?? this.numCurrentFemale,
      numCurrentMale: numCurrentMale ?? this.numCurrentMale,
      numMaxFemale: numMaxFemale ?? this.numMaxFemale,
      numMaxMale: numMaxMale ?? this.numMaxMale,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      hostID: hostID ?? this.hostID,
    );
  }
}
