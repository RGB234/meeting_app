import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';
import "package:meeting_app/constants/gaps.dart";
import 'package:meeting_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void onSignUpTap(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                LoginBtn(text: "Continue with Google"),
                Gaps.v24,
                const Text("계정을 새로 생성해야 하나요?"),
                Gaps.v8,
                GestureDetector(
                  onTap: () => onSignUpTap(context),
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

class LoginBtn extends StatelessWidget {
  final String text;

  const LoginBtn({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        padding: EdgeInsets.all(Sizes.size8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: Sizes.size16,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
