import 'package:flutter/material.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/screens/home_screen.dart';

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
  void dispose() {
    // memory de-allocation (destructor?)
    _usernameFieldController.dispose();
    _emailFieldController.dispose();
    _passwordFieldController.dispose();
    super.dispose();
  }

  bool _isUsernameValid() {
    if (_username.isEmpty) return false;
    // no whitespace (for the time being)
    final regExp = RegExp(r"[ㄱ-ㅎㅏ-ㅣ가-힣a-z0-9A-Z]{1,12}");
    if (!regExp.hasMatch(_username)) {
      return false;
    } else {
      return true;
    }
  }

  bool _isEmailValid() {
    if (_email.isEmpty) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_email)) {
      return false;
    } else {
      return true;
    }
  }

  bool _isPasswordValid() {
    if (_password.isEmpty) return false;
    final regExp = RegExp(r"[\w\d`~!@#$%^&*()\-_=+]{1,16}");
    if (!regExp.hasMatch(_password)) {
      return false;
    } else {
      return true;
    }
  }

  bool _isValidForm() {
    if (_isUsernameValid() && _isEmailValid() && _isPasswordValid()) {
      return true;
    } else {
      return false;
    }
  }

  void _onSubmitTap() {
    if (_isValidForm()) {
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    }
  }

  void _onScaffoldTap() {
    // Scaffold Tap == unfocus
    // For Textfield unfocusing
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
                TextField(
                  autocorrect: false,
                  controller: _usernameFieldController,
                  decoration: InputDecoration(
                    hintText: "사용자 별명 (username)",
                    errorText: _isUsernameValid() ? "" : "한글, 숫자, 영어 조합 12자리",
                  ),
                ),
                Gaps.v12,
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  controller: _emailFieldController,
                  decoration: InputDecoration(
                    hintText: "Email",
                    errorText: _isEmailValid() ? "" : "Invalid Email format",
                  ),
                ),
                Gaps.v12,
                TextField(
                  autocorrect: false,
                  controller: _passwordFieldController,
                  decoration: InputDecoration(
                    hintText: "비밀번호",
                    errorText: _isPasswordValid()
                        ? ""
                        : "최소 1자리 - 최대 16자리. 영문,숫자,특수문자 사용가능.",
                  ),
                ),
                Gaps.v36,
                // Submit Btn
                AnimatedContainer(
                  padding: const EdgeInsets.all(
                    Sizes.size12,
                  ),
                  decoration: BoxDecoration(
                    color: _isValidForm()
                        ? Theme.of(context).primaryColor
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(
                      Sizes.size10,
                    ),
                  ),
                  duration: const Duration(
                    milliseconds: 400,
                  ),
                  child: GestureDetector(
                    onTap: () => _onSubmitTap(),
                    child: const Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: Sizes.size12,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
