import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/widgets/email_login_form.dart';

class EmailLogInScreen extends StatefulWidget {
  const EmailLogInScreen({super.key});

  @override
  State<EmailLogInScreen> createState() => _EmailLogInScreenState();
}

class _EmailLogInScreenState extends State<EmailLogInScreen> {
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
                  "Log In",
                  style: TextStyle(
                    fontSize: Sizes.size28,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Gaps.v8,
                Gaps.v48,
                EmailLogInForm(),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
