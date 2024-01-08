import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';
import "package:meeting_app/constants/gaps.dart";
import 'package:meeting_app/screens/authentication/signup_screen.dart';
import 'package:meeting_app/widgets/auth_btn.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => const SignupScreen(),
    ));
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
                  "Login",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v24,
                const AuthBtns(
                  isSignUp: false,
                ),
                Gaps.v24,
                const Text("계정을 새로 생성해야 하나요?"),
                Gaps.v8,
                GestureDetector(
                  onTap: () => _onSignUpTap(context),
                  child: const Text(
                    "Sign Up",
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
