import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  final TextEditingController _usernameFieldController =
      TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _passwordFieldController =
      TextEditingController();

  String _username = "";
  String _email = "";
  String _password = "";

  @override
  void initState() {
    super.initState();

    _usernameFieldController.addListener(() {
      setState(() {
        _username = _usernameFieldController.text;
      });
    });
    _emailFieldController.addListener(() {
      setState(() {
        _email = _emailFieldController.text;
      });
    });
    _passwordFieldController.addListener(() {
      setState(() {
        _password = _passwordFieldController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Center(
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
            Gaps.v48,
            _SignUpFields(
                usernameFieldController: _usernameFieldController,
                emailFieldController: _emailFieldController,
                passwordFieldController: _passwordFieldController),
          ]),
        ),
      ),
    );
  }
}

class _SignUpFields extends StatelessWidget {
  const _SignUpFields({
    super.key,
    required TextEditingController usernameFieldController,
    required TextEditingController emailFieldController,
    required TextEditingController passwordFieldController,
  })  : _usernameFieldController = usernameFieldController,
        _emailFieldController = emailFieldController,
        _passwordFieldController = passwordFieldController;

  final TextEditingController _usernameFieldController;
  final TextEditingController _emailFieldController;
  final TextEditingController _passwordFieldController;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: Column(
        children: [
          TextField(
            controller: _usernameFieldController,
            decoration: const InputDecoration(
              hintText: "사용자 별명 (username)",
            ),
          ),
          Gaps.v12,
          TextField(
            controller: _emailFieldController,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          Gaps.v12,
          TextField(
            controller: _passwordFieldController,
            decoration: const InputDecoration(
              hintText: "비밀번호",
            ),
          ),
          Gaps.v36,
          AnimatedContainer(
            padding: const EdgeInsets.all(
              Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
            duration: const Duration(
              milliseconds: 200,
            ),
            child: const Text(
              "회원가입",
              style: TextStyle(
                fontSize: Sizes.size12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
