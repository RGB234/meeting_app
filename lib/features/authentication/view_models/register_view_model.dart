import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';
import 'package:meeting_app/utils.dart';

class RegisterViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> register(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(registerForm);
    final user = ref.read(userProvider.notifier);
    state = await AsyncValue.guard(
      () async {
        final UserCredential credential = await _authRepo.register(
          form["email"],
          form["password"],
        );
        await user.createProfile(credential);
      },
    );
    while (true) {
      // wait until context.mounted == true
      if (context.mounted) {
        if (state.hasError) {
          showFirebaseErrorSnack(context, state.error);
        }
        break;
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
  }

  bool isSignedIn() {
    return ref.read(authRepo).isSignedIn;
  }
}

final registerForm = StateProvider((ref) => {});

final registerProvider = AsyncNotifierProvider<RegisterViewModel, void>(
  () => RegisterViewModel(),
);
