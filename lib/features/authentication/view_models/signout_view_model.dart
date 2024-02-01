import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/utils.dart';

class SignOutViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signOut(BuildContext context) async {
    await _authRepo.signOut();

    if (context.mounted) {
      if (state.hasError) {
        showFirebaseErrorSnack(context, state.error);
      }
    }
  }
}

final signOutProvider =
    AsyncNotifierProvider<SignOutViewModel, void>(() => SignOutViewModel());
