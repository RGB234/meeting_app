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

  Map<String, String> toJson() {
    return {
      "uid": uid,
      "email": email,
      "username": username,
      "sex": sex ?? "None(sex)",
      "age": age ?? "None(age)",
      "photoURL": photoURL ?? "None(photoURL)",
      "phoneNumber": phoneNumber ?? "None(phoneNumber)",
      "affiliation": affiliation ?? "None(affiliation)",
    };
  }
}
