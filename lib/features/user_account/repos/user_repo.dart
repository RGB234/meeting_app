import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> createProfile(UserProfileModel profile) async {
    await _db.collection("users").doc(profile.uid).set(profile.toJson());
  }

  Future<Map<String, dynamic>?> fetchProfile(String uid) async {
    final doc = await _db.collection("users").doc(uid).get();
    return doc.data();
  }

  Future<void> updateProfile(String uid, Map<String, dynamic> data) async {
    await _db.collection("users").doc(uid).update(data);
  }

  Future<void> uploadPhoto({
    required String uid,
    required String fileName,
    required File file,
  }) async {
    final fileRef = _storage.ref().child("profile/$fileName");
    await fileRef.putFile(file);
    final fileURL = await fileRef.getDownloadURL();
    await updateProfile(uid, {"photoURL": fileURL});
  }
}

final userRepo = Provider((ref) => UserRepository());
