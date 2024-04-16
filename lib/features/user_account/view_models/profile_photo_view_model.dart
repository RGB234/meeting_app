import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';

class ProfilePhotoViewModel extends FamilyAsyncNotifier<String, String> {
  late final UserRepository _userRepo;

  @override
  FutureOr<String> build(String arg) async {
    _userRepo = ref.read(userRepo);
    final snapshot = await _userRepo.findUserById(arg);

    debugPrint("profile_photo_vm build");

    return snapshot.data()!["photoURL"] as String;
  }

  Future<void> uploadPhoto(File file) async {
    final user = ref.read(authRepo).user;
    final fileName = user!.uid;
    state = const AsyncValue.loading();
    debugPrint("uploadPhoto");
    state = await AsyncValue.guard(() =>
        _userRepo.uploadPhoto(uid: user.uid, fileName: fileName, file: file));
  }
}

final profilePhotoProvider =
    AsyncNotifierProvider.family<ProfilePhotoViewModel, String, String>(
  () => ProfilePhotoViewModel(),
);
