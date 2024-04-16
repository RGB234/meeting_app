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

enum Gender {
  male("male"),
  female("female"),
  others("others");

  const Gender(this.gender);
  final String gender;

  factory Gender.valueIs(String gender) {
    return values.firstWhere((element) => element.name == gender);
  }
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Map<String, String> formData = {};
  String? _birthday;

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
      firstDate: DateTime(1900),
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
        await ref.read(userProvider.notifier).updateProfile(formData);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const TextStyle titleTextStyle =
        TextStyle(fontSize: Sizes.size14, fontWeight: FontWeight.w600);
    const TextStyle subtitleTextStyle =
        TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w400);

    SizedBox SmallGaps = Gaps.v12;
    SizedBox BigGaps = Gaps.v28;

    return ref.watch(userProvider).when(
        loading: () =>
            const Center(child: CircularProgressIndicator.adaptive()),
        error: (error, stackTrace) {
          debugPrint(stackTrace.toString());
          return Scaffold(
            appBar: AppBar(),
            body: Center(child: Text(error.toString())),
          );
        },
        data: (data) {
          return GestureDetector(
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
                        // ProfilePhoto 위젯 (View 에 해당)은 내부적으로 profilePhotoProvider 를 watch
                        // 즉, UserProfileScreen 과 ProfilePhoto 가 watch 하는 provider 가 다르다.
                        // 고로 userProvider 의 state 가 변경되어도 ProfilePhoto 는 re-rendering 되지 않고 반대도 마찬가지

                        // 좀 더 자세히 살펴보면 ProfilePhoto 는 사실
                        ProfilePhoto(
                          uid: data.uid,
                        ),
                        Gaps.v12,
                        const Text("사진을 클릭하면 변경할 수 있습니다"),
                        Gaps.v44,
                        SizedBox(
                          width: 250,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("이메일", style: titleTextStyle),
                              SmallGaps,
                              Text(
                                data.email,
                                style: subtitleTextStyle,
                              ),
                              SmallGaps,
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.black12,
                                    ),
                                  ),
                                  child: const Text("이메일 & 비밀번호 변경하기"),
                                ),
                              ),
                              BigGaps,
                              Form(
                                key: _formkey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "이름",
                                      style: titleTextStyle,
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                          hintText: data.username),
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
                                    BigGaps,
                                    const Text(
                                      "전화번호",
                                      style: titleTextStyle,
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
                                    BigGaps,
                                    const Text(
                                      "소속 (기업, 대학, 외 기타)",
                                      style: titleTextStyle,
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
                                    BigGaps,
                                    const Text(
                                      "생일",
                                      style: titleTextStyle,
                                    ),
                                    SmallGaps,
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
                                    ),
                                  ],
                                ),
                              ),
                              BigGaps,
                              const Text(
                                "성별",
                                style: titleTextStyle,
                              ),
                              SmallGaps,
                              Text(
                                data.gender,
                                style: subtitleTextStyle,
                              ),
                              SmallGaps,
                              SizedBox(
                                width: double.infinity,
                                child: TextButton(
                                  onPressed: () {},
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                      Colors.black12,
                                    ),
                                  ),
                                  child: const Text("성별 변경하기"),
                                ),
                              ),
                            ],
                          ),
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
          );
        });
  }
}
