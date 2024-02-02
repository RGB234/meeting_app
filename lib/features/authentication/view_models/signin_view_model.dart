import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/utils.dart';

class SignInViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signIn(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signInForm);
    state = await AsyncValue.guard(
      () async => _authRepo.signIn(
        form['email'],
        form['password'],
      ),
    );
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
  }
}

final signInForm = StateProvider((ref) => {});

final signInProvider =
    AsyncNotifierProvider<SignInViewModel, void>(() => SignInViewModel());
