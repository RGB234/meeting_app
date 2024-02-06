import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/user_account/repos/user_repo.dart';

class ProfilePhotoViewModel extends AsyncNotifier<void> {
  late final UserRepository _userRepo;

  @override
  FutureOr<void> build() {
    _userRepo = ref.read(userRepo);
  }

  Future<void> uploadPhoto(File file) async {
    final user = ref.read(authRepo).user;
    final fileName = user!.uid;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() =>
        _userRepo.uploadPhoto(uid: user.uid, fileName: fileName, file: file));
  }
}

final profilePhotoProvider = AsyncNotifierProvider<ProfilePhotoViewModel, void>(
  () => ProfilePhotoViewModel(),
);
