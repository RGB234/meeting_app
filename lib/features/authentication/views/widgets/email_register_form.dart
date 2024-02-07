import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/view_models/register_view_model.dart';
import 'package:meeting_app/utils.dart';

class EmailRegisterForm extends ConsumerStatefulWidget {
  const EmailRegisterForm({super.key});

  @override
  ConsumerState<EmailRegisterForm> createState() => _EmailRegisterFormState();
}

class _EmailRegisterFormState extends ConsumerState<EmailRegisterForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isObsecure = true;
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        ref.read(registerForm.notifier).state = {
          "username": formData["username"],
          "email": formData["email"],
          "password": formData["password"],
        };
        // create account, sign in, and then go to initiallocation
        ref.read(registerProvider.notifier).register(context);
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
            validator: (value) =>
                AuthenticationValidator.isUsernameValid(value: value),
            // memo : newValue is the value it had at the moment the _onSubmit function was executed.
            onSaved: (newValue) {
              if (newValue != null) {
                formData['username'] = newValue;
              }
            },
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: "Username",
            ),
          ),
          Gaps.v12,
          TextFormField(
            validator: (value) =>
                AuthenticationValidator.isEmailValid(value: value),
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
            validator: (value) =>
                AuthenticationValidator.isPasswordValid(value: value),
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
              child: ref.watch(registerProvider).isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(
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
