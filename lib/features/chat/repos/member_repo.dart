// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:meeting_app/features/user_account/models/user_profile_model.dart';

// class MemberRepository {
//   final FirebaseFirestore _db = FirebaseFirestore.instance;

//   Future<List<UserProfileModel>> getListOfMembersIn(
//       {required String roomID}) async {
//     List<UserProfileModel> members = [];
//     QuerySnapshot<Map<String, dynamic>> snapshot =
//         await _db.collection('rooms').doc(roomID).collection('members').get();

//     for (final doc in snapshot.docs) {
//       final userId = doc.id;
//       final user = await _db.collection("users").doc(userId).get();
//       members.add(UserProfileModel.fromJson(user.data()!));
//     }

//     return members;
//   }

//   Future<List<int>> countMembers({required String roomID}) async {
//     int male = 0;
//     int female = 0;

//     final members = await getListOfMembersIn(roomID: roomID);

//     for (final member in members) {
//       final gender = member.gender;
//       if (gender == 'male') {
//         male++;
//       } else {
//         female++;
//       }
//     }
//     return [male, female];
//   }
// }

// final memberRepo = Provider((ref) => MemberRepository());
