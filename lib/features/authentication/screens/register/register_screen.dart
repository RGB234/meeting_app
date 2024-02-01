import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/screens/signin/signin_screen.dart';
import 'package:meeting_app/features/authentication/widgets/auth_btn.dart';

class RegisterScreen extends StatelessWidget {
  static String routePath = "/Register";
  static String routeName = "Register";
  const RegisterScreen({super.key});

  void _onSigninTap(BuildContext context) {
    context.replaceNamed(
      SigninScreen.routeName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size36,
              vertical: Sizes.size28,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Gaps.v96,
                const Text(
                  "Register",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v24,
                const AuthBtns(
                  isRegister: true,
                ),
                Gaps.v24,
                const Text("이미 생성한 계정이 있나요?"),
                Gaps.v8,
                GestureDetector(
                  onTap: () => _onSigninTap(context),
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
