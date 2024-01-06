import "package:flutter/material.dart";
import "package:meeting_app/constants/sizes.dart";
import "package:meeting_app/constants/gaps.dart";

class GroupChat extends StatelessWidget {
  final String text;

  const GroupChat({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.size10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              Icon(
                Icons.ac_unit,
                size: Sizes.size32,
              ),
              Gaps.v8,
              Text("2/4 : 4/4"),
            ],
          ),
          Gaps.h24,
          Text(
            text,
            style: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class GroupChats extends StatelessWidget {
  const GroupChats({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
        GroupChat(
          text: "kfgkajfajfbalfblafa",
        ),
      ],
    );
  }
}
