import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  // ** 중요 로그아웃시 userProvider 는 invalidate() 를 통해 dispose 되어 사라질 예정
  // 로그인하여 다시 userProvider 를 listen 하게 되면 userProvider 객체는 다시 생성된다.
  // 이렇게 하여 이전에 로그인한 계정의 정보가 남아있지 않도록 구현하였다. 자세한 설명은 signout_view_model.dart 에 추가.
  @override
  FutureOr<UserProfileModel> build() async {
    _userRepo = ref.read(userRepo);
    _authRepo = ref.read(authRepo);
    late final UserProfileModel userProfile;

    if (_authRepo.isSignedIn) {
      state = const AsyncValue.loading();
      final profile = await _userRepo.fetchProfile(_authRepo.user!.uid);
      if (profile != null) {
        userProfile = UserProfileModel.fromJson(profile);
        state = AsyncValue.data(userProfile);
      }
    } else {
      userProfile = UserProfileModel.empty();
      state = AsyncValue.data(userProfile);
    }
    return userProfile;
  }

  Future<void> createProfile(UserCredential credential) async {
    final form = ref.read(registerForm);
    if (credential.user == null) {
      throw Exception("Failed to create new account");
    }
    state = const AsyncValue.loading();
    UserProfileModel userProfile = UserProfileModel(
      uid: credential.user!.uid,
      username: form["username"] ?? credential.user!.displayName,
      email: form["email"] ?? credential.user!.email,
    );
    await _userRepo.createProfile(userProfile);
    state = AsyncValue.data(userProfile);
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    await _userRepo.updateProfile(_authRepo.user!.uid, data);
    // refresh
    ref.invalidateSelf();
  }

  Future<UserProfileModel> fetchUserProfile({required String uid}) async {
    late UserProfileModel userProfile;
    final snapshot = await _userRepo.findUserById(uid);

    if (snapshot.exists) {
      userProfile = UserProfileModel.fromJson(snapshot.data()!);
    } else {
      userProfile = UserProfileModel.empty();
    }
    return userProfile;
  }
}

final userProvider = AsyncNotifierProvider<UserViewModel, UserProfileModel>(
  () {
    return UserViewModel();
  },
);

final userProviderById =
    AutoDisposeFutureProviderFamily<UserProfileModel, String>((ref, uid) async {
  final repo = ref.read(userRepo);
  late UserProfileModel userProfile;
  final snapshot = await repo.findUserById(uid);

  if (snapshot.exists) {
    userProfile = UserProfileModel.fromJson(snapshot.data()!);
  } else {
    userProfile = UserProfileModel.empty();
  }
  debugPrint("몇 번 호출되는지 테스트(userProviderById)");
  return userProfile;
});
