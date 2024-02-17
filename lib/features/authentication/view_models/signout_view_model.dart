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
    // **중요**
    // userProvider 의 state 는 autoDispose 가 아니기 때문에
    // invalidate 하지 않을 경우 로그아웃해도 남아있다.
    // 정확히는 userProvider 를 listen 하고 있지 않는 화면에서 invalidate 를 하면
    // 이때는 userProvider 를 listen 하는 리스너가 위젯트리상에 없기 때문에
    // provider 는 폐기된다. 마찬가지로 provider 가 보관하는 데이터인 state 도 지워진다.
    // 다시 로그인하여 userProvider 를 listen 하는 화면으로 가면 userProvider 객체가 새로 생성된다.
    // userProvider 는 AsyncNotifierProvider 로서, 현재 argument인  _createNotifier 함수로
    // UserViewModel 을 return 하는 함수를 등록한 상태다.
    // 정확하진 않지만 userProvider 객체가 새로 생성되면서 argument 인 _createNotifier 함수를 실행하는 듯 하다.
    // 위의 추론이 맞다면 _createNotifier 가 실행되면서 UserViewModel 이 return 되고, UserViewModel 의 생성자가
    // 실행되면서 UserViewModel 의 build 메서드가 실행된다.
    // build 메서드 내부에는 userProvider 의 state 를 변경하도록 구현이 되어있는 상태.
    // userProvider 의 state 가 변경이 되면 이 provider 의 state 를 사용하는 위젯(리스너)들에게 이벤트(?)가 전달되어
    // 리스너들이 rebuild 된다.

    // 요약하자면, 로그아웃이 userProvider 를 수동으로 dispose 하면서 userProvider 메모리에서 지우고
    // 다시 로그인해서 userProvider 를 listen 하는 페이지로 가면 다시 userProvider 가 생성.
    // 수동으로 dispose 하지 않으면, 이전에 로그인한 계정의 정보가 그대로 남아있음.
    // 프로필 화면상에 제출버튼을 누르면 새로고침되면서(invalidateSelf() 를 하면서 state를 새로 계산) 새로 계정정보를 받아오기는 한다.
    ref.invalidate(userProvider);
  }
}

final signOutProvider =
    AsyncNotifierProvider<SignOutViewModel, void>(() => SignOutViewModel());
