import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/authentication/view_models/register_view_model.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';

class UserViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _userRepo;
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);

    if (_authRepo.isSignedIn) {
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

  Future<void> modifyProfile(UserCredential credential) async {}
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () => UserViewModel(),
);
