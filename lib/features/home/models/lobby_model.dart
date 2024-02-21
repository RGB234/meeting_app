class LobbyModel {
  final String id;
  final String image;
  final int numCurrentFemale;
  final int numCurrentMale;
  final int numMaxFemale;
  final int numMaxMale;
  final String title;
  final String createdAt;
  final String createdBy;

  LobbyModel({
    required this.id,
    required this.image,
    required this.numCurrentFemale,
    required this.numCurrentMale,
    required this.numMaxFemale,
    required this.numMaxMale,
    required this.title,
    required this.createdAt,
    required this.createdBy,
  });

  LobbyModel.empty()
      : id = "",
        image = "",
        numCurrentFemale = 0,
        numCurrentMale = 0,
        numMaxFemale = 4,
        numMaxMale = 4,
        title = "",
        createdAt = "",
        createdBy = "";

  LobbyModel.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        image = json["image"],
        numCurrentFemale = json["numCurrentFemale"],
        numCurrentMale = json["numCurrentMale"],
        numMaxFemale = json["numMaxFemale"],
        numMaxMale = json["numMaxMale"],
        title = json["title"],
        createdAt = json["createdAt"],
        createdBy = json["createdBy"];

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "image": image,
      "numCurrentFemale": numCurrentFemale,
      "numCurrentMale": numCurrentMale,
      "numMaxFemale": numMaxFemale,
      "numMaxMale": numMaxMale,
      "title": title,
      "createdAt": createdAt,
      "createdBy": createdBy,
    };
  }

  LobbyModel copyWith({
    String? id,
    String? image,
    int? numCurrentFemale,
    int? numCurrentMale,
    int? numMaxFemale,
    int? numMaxMale,
    String? subtitle,
    String? title,
    String? createdAt,
    String? createdBy,
  }) {
    return LobbyModel(
      id: id ?? this.id,
      image: image ?? this.image,
      numCurrentFemale: numCurrentFemale ?? this.numCurrentFemale,
      numCurrentMale: numCurrentMale ?? this.numCurrentMale,
      numMaxFemale: numMaxFemale ?? this.numMaxFemale,
      numMaxMale: numMaxMale ?? this.numMaxMale,
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
