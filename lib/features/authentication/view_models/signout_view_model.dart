import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';
import 'package:meeting_app/utils.dart';

class SignOutViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signOut(BuildContext context) async {
    await _authRepo.signOut();

    while (true) {
      // context.mounted가 true가 될 때까지 대기
      if (context.mounted) {
        if (state.hasError) {
          showFirebaseErrorSnack(context, state.error);
        }
        break;
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
      }
    }
    ref.invalidate(userProvider);
  }
}

final signOutProvider =
    AsyncNotifierProvider<SignOutViewModel, void>(() => SignOutViewModel());