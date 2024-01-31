import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';

class RegisterViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepository _authRepo;
  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> register() async {
    state = const AsyncValue.loading();
    final form = ref.read(registerForm);
    state = await AsyncValue.guard(
      () async => _authRepo.register(
        form["email"],
        form["password"],
      ),
    );
  }

  Future<void> signOut() async {
    await _authRepo.signOut();
  }

  bool isSignedIn() {
    return ref.read(authRepo).isSignedIn;
  }
}

final registerForm = StateProvider((ref) => {});

final registerProvider = AsyncNotifierProvider<RegisterViewModel, void>(
  () => RegisterViewModel(),
);
