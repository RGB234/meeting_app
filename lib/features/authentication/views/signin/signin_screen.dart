import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/constants/sizes.dart';
import "package:meeting_app/constants/gaps.dart";
import 'package:meeting_app/features/authentication/views/register/register_screen.dart';
import 'package:meeting_app/features/authentication/views/widgets/auth_btn.dart';

class SigninScreen extends StatelessWidget {
  static String routePath = "/Signin";
  static String routeName = "Signin";
  const SigninScreen({super.key});

  void _onRegisterTap(BuildContext context) {
    context.replaceNamed(
      RegisterScreen.routeName,
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
                  "Sign in",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v24,
                const AuthBtns(
                  isRegister: false,
                ),
                Gaps.v24,
                const Text("계정을 새로 생성해야 하나요?"),
                Gaps.v8,
                GestureDetector(
                  onTap: () => _onRegisterTap(context),
                  child: const Text(
                    "Register",
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
