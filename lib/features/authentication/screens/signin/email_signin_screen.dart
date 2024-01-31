import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/widgets/email_signin_form.dart';

class EmailSigninScreen extends StatefulWidget {
  static String routePath = "email";
  static String routeName = "emailSignin";
  const EmailSigninScreen({super.key});

  @override
  State<EmailSigninScreen> createState() => _EmailSigninScreenState();
}

class _EmailSigninScreenState extends State<EmailSigninScreen> {
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
        body: const SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Sizes.size36,
                vertical: Sizes.size28,
              ),
              child: Column(children: [
                Gaps.v60,
                Text(
                  "Sign in",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v8,
                Gaps.v48,
                EmailSigninForm(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
