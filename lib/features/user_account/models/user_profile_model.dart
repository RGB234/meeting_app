class UserProfileModel {
  final String uid;
  final String email;
  final String username;
  final String? sex;
  final String? age;
  final String? foregroundPhotoURL;
  final String? backgroundPhotoURL;
  final String? phoneNumber;
  final String? affiliation;

  UserProfileModel({
    required this.uid,
    required this.email,
    required this.username,
    this.sex,
    this.age,
    this.foregroundPhotoURL,
    this.backgroundPhotoURL,
    this.phoneNumber,
    this.affiliation,
  });

  UserProfileModel.empty()
      : uid = "",
        username = "",
        email = "",
        sex = "",
        age = "",
        foregroundPhotoURL = "",
        backgroundPhotoURL = "",
        phoneNumber = "",
        affiliation = "";
}
