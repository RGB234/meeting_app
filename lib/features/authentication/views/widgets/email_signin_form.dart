import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:meeting_app/constants/gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/authentication/view_models/signin_view_model.dart';
import 'package:meeting_app/utils.dart';

class EmailSigninForm extends ConsumerStatefulWidget {
  const EmailSigninForm({super.key});

  @override
  ConsumerState<EmailSigninForm> createState() => _EmailSigninFormState();
}

class _EmailSigninFormState extends ConsumerState<EmailSigninForm> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool _isObsecure = true;
  Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        ref.read(signInForm.notifier).state = {
          'email': formData['email'],
          'password': formData['password'],
        };
        ref.read(signInProvider.notifier).signIn(context);

        // context.goNamed(HomeScreen.routeName, pathParameters: {'tab': 'home'});

        // Navigator.of(context).pushAndRemoveUntil(
        //   MaterialPageRoute(
        //     builder: (context) => const HomeScreen(
        //       tab: "home",
        //     ),
        //   ),
        //   (route) => false,
        // );
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
              child: ref.watch(signInProvider).isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text(
                      "Sign in",
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
