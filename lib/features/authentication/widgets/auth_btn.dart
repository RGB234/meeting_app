import 'package:flutter/material.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/features/authentication/screens/signin/email_signin_screen.dart';
import 'package:meeting_app/features/authentication/screens/register/email_register_screen.dart';

class AuthBtn extends StatelessWidget {
  final String text;
  final FaIcon icon;

  const AuthBtn({
    super.key,
    required this.text,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Container(
        padding: const EdgeInsets.all(Sizes.size12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black38),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: icon,
            ),
            Text(
              text,
              style: const TextStyle(
                fontSize: Sizes.size16,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthBtns extends StatelessWidget {
  final bool isRegister;
  const AuthBtns({
    super.key,
    required this.isRegister,
  });

  void _onEmailTap(BuildContext context) {
    if (isRegister) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailRegisterScreen(),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const EmailSigninScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        GestureDetector(
          onTap: () => _onEmailTap(context),
          child: const AuthBtn(
            text: "Email & Password",
            icon: FaIcon(FontAwesomeIcons.envelope),
          ),
        ),
        Gaps.v12,
        GestureDetector(
          child: const AuthBtn(
            text: "Continue with Google",
            icon: FaIcon(FontAwesomeIcons.google),
          ),
        ),
      ],
    );
  }
}
