import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repo;
  @override
  FutureOr<UserProfileModel> build() async {
    _repo = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    // just for now, username wrote on Register Page is not used at all.
    // because firebase email-authentication api only use email and password
    // this problem will be handled when we write down our server code, not firebase.
    if (credential.user == null) {
      throw Exception("Failed to create new account");
    }
    UserProfileModel userProfile = UserProfileModel(
      uid: credential.user!.uid,
      username: credential.user!.displayName ?? "None",
      email: credential.user!.email ?? "None",
    );
    await _repo.createProfile(userProfile);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, void>(
  () => UserViewModel(),
);
