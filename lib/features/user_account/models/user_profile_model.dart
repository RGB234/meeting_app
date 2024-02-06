class UserProfileModel {
  final String uid;
  final String email;
  final String username;
  final String? sex;
  final String? age;
  final String? photoURL;
  final String? phoneNumber;
  final String? affiliation;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.username,
    this.sex,
    this.age,
    this.photoURL,
    this.phoneNumber,
    this.affiliation,
  });

  UserProfileModel.empty()
      : uid = "",
        email = "",
        username = "",
        sex = "",
        age = "",
        photoURL = "",
        phoneNumber = "",
        affiliation = "";

  UserProfileModel.fromJson(Map<String, dynamic> json)
      : uid = json["uid"],
        email = json["email"],
        username = json["username"],
        sex = json["sex"],
        age = json["age"],
        photoURL = json["photoURL"],
        phoneNumber = json["phoneNumber"],
        affiliation = json["affiliation"];

  Map<String, String?> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "sex": sex ?? "None(sex)",
      "age": age ?? "None(age)",
      "photoURL": photoURL,
      "phoneNumber": phoneNumber ?? "None(phoneNumber)",
      "affiliation": affiliation ?? "None(affiliation)",
    };
  }

  UserProfileModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? sex,
    String? age,
    String? photoURL,
    String? phoneNumber,
    String? affiliation,
  }) {
    return UserProfileModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      sex: sex ?? this.sex,
      age: age ?? this.age,
      photoURL: photoURL ?? this.photoURL,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      affiliation: affiliation ?? this.affiliation,
    );
  }
}
