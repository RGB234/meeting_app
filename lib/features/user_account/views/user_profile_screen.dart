import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';
import 'package:meeting_app/features/user_account/views/widgets/profile_photo.dart';
import 'package:meeting_app/utils.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "profile";
  static String routePath = "/profile";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  String? _birthday;
  final List<String> _genders = ["male", "female", "ohters"];

  void _onUserNameSaved(
      {required UserProfileModel data, required String? value}) {
    if (value == null) return;
    if (value.isEmpty) {
      formData["username"] = data.username;
    } else {
      formData["username"] = value;
    }
  }

  void _onPhoneNumberSaved({
    required UserProfileModel data,
    required String? value,
  }) {
    if (value == null) return;
    if (value.isEmpty) {
      formData["phoneNumber"] = data.phoneNumber;
    } else {
      formData["phoneNumber"] = value;
    }
  }

  void _onAffiliationSaved({
    required UserProfileModel data,
    required String? value,
  }) {
    if (value == null) return;
    if (value.isEmpty) {
      formData["affiliation"] = data.affiliation;
    } else {
      formData["affiliation"] = value;
    }
  }

  Future<void> _onSelectDate(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (selectedDate != null) {
      setState(() {
        _birthday = DateFormat.yMMMd().format(selectedDate);
      });
      if (_birthday == null) return;
      if (_birthday!.isEmpty) return;
      formData["birthday"] = _birthday!;
    }
  }

  void _onSubmitTap() async {
    if (_formkey.currentState != null) {
      if (_formkey.currentState!.validate()) {
        _formkey.currentState!.save();
        ref.read(userProvider.notifier).updateProfile(formData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (data) => GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.size12,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        ProfilePhoto(
                          username: data.username,
                          photoURL: data.photoURL,
                        ),
                        Gaps.v12,
                        const Text("사진을 클릭하면 변경할 수 있습니다"),
                        Gaps.v12,
                        // should be updated
                        TextButton(
                          onPressed: () {},
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.black12,
                            ),
                          ),
                          child: const Text("이메일 & 비밀번호 변경하기"),
                        ),
                        Gaps.v32,
                        SizedBox(
                          width: 250,
                          child: Form(
                            key: _formkey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "이름",
                                  style: TextStyle(
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextFormField(
                                  decoration:
                                      InputDecoration(hintText: data.username),
                                  textAlign: TextAlign.start,
                                  autocorrect: false,
                                  validator: (value) {
                                    if (value == null) return null;
                                    if (value.isEmpty) return null;
                                    return AuthenticationValidator
                                        .isUsernameValid(value: value);
                                  },
                                  onSaved: (value) => _onUserNameSaved(
                                    data: data,
                                    value: value,
                                  ),
                                ),
                                Gaps.v28,
                                const Text(
                                  "전화번호",
                                  style: TextStyle(
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                      hintText: data.phoneNumber),
                                  textAlign: TextAlign.start,
                                  autocorrect: false,
                                  // validator should be updated
                                  onSaved: (value) {
                                    _onPhoneNumberSaved(
                                      data: data,
                                      value: value,
                                    );
                                  },
                                ),
                                Gaps.v28,
                                const Text(
                                  "소속 (기업, 대학, 외 기타)",
                                  style: TextStyle(
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w600),
                                ),
                                TextFormField(
                                  decoration: InputDecoration(
                                      hintText: data.affiliation),
                                  textAlign: TextAlign.start,
                                  autocorrect: false,
                                  // validator should be updated
                                  onSaved: (value) => _onAffiliationSaved(
                                    data: data,
                                    value: value,
                                  ),
                                ),
                                Gaps.v28,
                                const Text(
                                  "생일",
                                  style: TextStyle(
                                      fontSize: Sizes.size14,
                                      fontWeight: FontWeight.w600),
                                ),
                                Gaps.v14,
                                GestureDetector(
                                  onTap: () => _onSelectDate(context),
                                  child: Row(
                                    children: [
                                      const Icon(
                                          FontAwesomeIcons.calendarCheck),
                                      Gaps.h10,
                                      Text(_birthday ?? data.birthday),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Gaps.v28,
                        DropdownMenu<String>(
                          onSelected: (value) {
                            setState(() {
                              formData["gender"] = value ?? "male";
                            });
                          },
                          label: const Text(
                            "성별",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          dropdownMenuEntries: _genders
                              .map((element) => DropdownMenuEntry<String>(
                                  value: element, label: element))
                              .toList(),
                        ),
                        Gaps.v28,
                        TextButton(
                          onPressed: () => _onSubmitTap(),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                              Colors.black12,
                            ),
                          ),
                          child: const Text("적용하기"),
                        ),
                        Gaps.v40,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
