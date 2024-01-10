import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/screens/home_screen.dart';

class EmailSignUpForm extends StatefulWidget {
  const EmailSignUpForm({super.key});

  @override
  State<EmailSignUpForm> createState() => _EmailSignUpFormState();
}

class _EmailSignUpFormState extends State<EmailSignUpForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isObsecure = true;
  Map<String, String> formData = {};

  String? _isUsernameValid({String? value}) {
    if (value == null) {
      return null;
    }
    final regExp = RegExp(r"[ㄱ-ㅎㅏ-ㅣ가-힣a-z0-9A-Z]{1,12}");
    if (regExp.hasMatch(value) && value.length < 13) {
      return null;
    } else if (value.isEmpty) {
      return "빈 칸을 채워야 합니다.";
    } else {
      return "한글, 알파벳, 숫자 조합. 1~12자리";
    }
  }

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
        Navigator.of(context).pop;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Column(
        children: [
          TextFormField(
            validator: (value) => _isUsernameValid(value: value),
            // memo : newValue is the value it had at the moment the _onSubmit function was executed.
            onSaved: (newValue) {
              if (newValue != null) {
                formData['username'] = newValue;
              }
            },
            autocorrect: false,
            decoration: InputDecoration(
              suffix: Row(mainAxisSize: MainAxisSize.min, children: [
                GestureDetector(
                  onTap: () {
                    _formkey.currentState?.reset();
                  },
                  child: const FaIcon(FontAwesomeIcons.xmark),
                )
              ]),
              hintText: "Username",
            ),
          ),
          Gaps.v12,
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
                "회원가입",
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