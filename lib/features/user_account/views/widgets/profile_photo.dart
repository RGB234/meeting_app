import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/user_account/view_models/profile_photo_view_model.dart';

class ProfilePhoto extends ConsumerStatefulWidget {
  final String uid;

  const ProfilePhoto({
    super.key,
    required this.uid,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePhotoState();
}

class _ProfilePhotoState extends ConsumerState<ProfilePhoto> {
  Future<void> _onUploadImage() async {
    final xfile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 60,
      maxHeight: 100,
      maxWidth: 100,
    );
    if (xfile != null) {
      final file = File(xfile.path);
      await ref
          .read(profilePhotoProvider(widget.uid).notifier)
          .uploadPhoto(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(profilePhotoProvider(widget.uid)).when(
          loading: () => const Padding(
            padding: EdgeInsets.only(top: Sizes.size12),
            child: CircularProgressIndicator.adaptive(),
          ),
          error: (error, stackTrace) {
            debugPrintStack(stackTrace: stackTrace);
            return Container(
              child: Text(error.toString()),
            );
          },
          data: (data) {
            // data is URL of userProfile's profile image
            return GestureDetector(
              onTap: () => _onUploadImage(),
              child: CircleAvatar(
                  radius: 80,
                  foregroundImage:
                      // NetworkImage basically use cache data if url is same.
                      // so, applied a trick to url for avoiding using cache data (same image), and re-fetching image data
                      NetworkImage("$data&date=${DateTime.now().toString()}")
                  // child: Center(
                  //   child: Text(widget.username),
                  // ),
                  ),
            );
          },
        );
  }
}
