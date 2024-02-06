import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/constants/Gaps.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/user_account/view_models/user_view_model.dart';
import 'package:meeting_app/features/user_account/views/widgets/profile_photo.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  static String routeName = "profile";
  static String routePath = "/profile";
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(userProvider).when(
          loading: () =>
              const Center(child: CircularProgressIndicator.adaptive()),
          error: (error, stackTrace) => Center(child: Text(error.toString())),
          data: (data) => Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfilePhoto(
                      username: data.username,
                      photoURL: data.photoURL,
                    ),
                    Gaps.v32,
                    Gaps.v32,
                    ListTile(
                      title: const Text("이름"),
                      subtitle: Text(data.username),
                    ),
                    ListTile(
                      title: const Text("이메일"),
                      subtitle: Text(data.email),
                    ),
                    ListTile(
                      title: const Text("성별"),
                      subtitle: Text(data.sex ?? "sex"),
                    ),
                    ListTile(
                      title: const Text("나이"),
                      subtitle: Text(data.age ?? "age"),
                    ),
                    ListTile(
                      title: const Text("전화번호"),
                      subtitle: Text(data.phoneNumber ?? "phone number"),
                    ),
                    ListTile(
                      title: const Text("소속"),
                      subtitle: Text(data.affiliation ?? "affiliation"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }
}
