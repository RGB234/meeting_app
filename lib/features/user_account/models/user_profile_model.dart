class UserProfileModel {
  final String uid;
  final String email;
  final String username;
  // if photoURL is null >> profile image is null
  final String? photoURL;
  final String gender;
  final String birthday;
  final String phoneNumber;
  final String affiliation;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.username,
    this.photoURL,
    this.gender = "None(gender)",
    this.birthday = "None(birthday)",
    this.phoneNumber = "None(phoneNumber)",
    this.affiliation = "None(affiliation)",
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        username = "",
        gender = "",
        birthday = "",
        photoURL = "",
        phoneNumber = "",
        affiliation = "";

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        username = json["username"],
        gender = json["gender"],
        birthday = json["birthday"],
        photoURL = json["photoURL"],
        phoneNumber = json["phoneNumber"],
        affiliation = json["affiliation"];

  Map<String, String?> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "gender": gender,
      "birthday": birthday,
      "photoURL": photoURL,
      "phoneNumber": phoneNumber,
      "affiliation": affiliation,
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? gender,
    String? birthday,
    String? photoURL,
    String? phoneNumber,
    String? affiliation,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      affiliation: affiliation ?? this.affiliation,
    );
  }
}
