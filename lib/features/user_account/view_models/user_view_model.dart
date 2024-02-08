import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/authentication/view_models/register_view_model.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  // _userRepo, and _authRepo will be updated
  // when a user changes profile setting or resign-in with another account
  // so, don't change these 'final'
  late UserRepository _userRepo;
  late AuthenticationRepository _authRepo;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    if (_authRepo.isSignedIn) {
      state = const AsyncValue.loading();
      final profile = await _userRepo.fetchProfile(_authRepo.user!.uid);
      if (profile != null) {
        return UserProfileModel.fromJson(profile);
      }
    }
    return UserProfileModel.empty();
  }

  Future<void> createProfile(UserCredential credential) async {
    final form = ref.read(registerForm);
    if (credential.user == null) {
      throw Exception("Failed to create new account");
    }
    state = const AsyncValue.loading();
    UserProfileModel userProfile = UserProfileModel(
      uid: credential.user!.uid,
      username: credential.user!.displayName ?? form["username"],
      email: credential.user!.email ?? "None",
    );
    await _userRepo.createProfile(userProfile);
    state = AsyncValue.data(userProfile);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    await _userRepo.updateProfile(_authRepo.user!.uid, data);
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () {
    return UserViewModel();
  },
);
