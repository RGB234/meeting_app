import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/widgets/email_signup_form.dart';

class EmailSignUpScreen extends StatefulWidget {
  static String routeName = "/signup/email";
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  void _onScaffoldTap() {
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onScaffoldTap,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size36,
                vertical: Sizes.size28,
              ),
              child: Column(children: [
                Gaps.v60,
                const Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v8,
                Text(
                  "회원가입 후 '내정보' 에서 변경가능합니다.",
                  style: TextStyle(
                    fontSize: Sizes.size12,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600,
                  ),
                ),
                // TextFields
                Gaps.v48,
                const EmailSignUpForm(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
