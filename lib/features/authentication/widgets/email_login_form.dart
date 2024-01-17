import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/home/home_screen.dart';

class EmailLogInForm extends StatefulWidget {
  const EmailLogInForm({super.key});

  @override
  State<EmailLogInForm> createState() => _EmailLogInFormState();
}

class _EmailLogInFormState extends State<EmailLogInForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isObsecure = true;
  Map<String, String> formData = {};

// ** temporary (start) **
  String? _isEmailValid({String? value}) {
    if (value == null) {
      return null;
    }
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (regExp.hasMatch(value)) {
      return null;
    } else if (value.isEmpty) {
      return "빈 칸을 채워야 합니다.";
    } else {
      return "유효하지 않은 이메일 형태입니다.";
    }
  }

  String? _isPasswordValid({String? value}) {
    if (value == null) {
      return null;
    }
    final regExp = RegExp(r"[\w\d`~!@#$%^&*()\-_=+]{8,16}");
    if (regExp.hasMatch(value) && value.length < 17) {
      return null;
    } else if (value.isEmpty) {
      return "빈 칸을 채워야 합니다.";
    } else {
      return "최소 8자리 - 최대 16자리. 알파벳, 숫자, 특수문자 조합 가능";
    }
  }

  void _onSubmitTap() {
    if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false,
        );
      }
    }
  }
// ** temporary (end) **

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _isEmailValid(value: value),
            onSaved: (newValue) {
              if (newValue != null) {
                formData['email'] = newValue;
              }
            },
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Email",
            ),
          ),
          Gaps.v12,
          TextFormField(
            validator: (value) => _isPasswordValid(value: value),
            onSaved: (newValue) {
              if (newValue != null) {
                formData['password'] = newValue;
              }
            },
            obscureText: _isObsecure,
            autocorrect: false,
            decoration: InputDecoration(
                hintText: "Password",
                suffix: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _isObsecure = !_isObsecure;
                        setState(() {});
                      },
                      child: FaIcon(
                        _isObsecure
                            ? FontAwesomeIcons.eyeSlash
                            : FontAwesomeIcons.eye,
                        size: Sizes.size20,
                      ),
                    ),
                  ],
                )),
          ),
          Gaps.v36,
          Container(
            padding: const EdgeInsets.all(
              Sizes.size12,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size10,
              ),
            ),
            child: GestureDetector(
              onTap: () => _onSubmitTap(),
              child: const Text(
                "Log In",
                style: TextStyle(
                  fontSize: Sizes.size12,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
