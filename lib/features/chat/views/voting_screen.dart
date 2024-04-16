import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';

class VotingScreen extends StatefulWidget {
  static String routePath = "/voting";
  static String routeName = "voting";
  const VotingScreen({super.key});

  @override
  State<VotingScreen> createState() => _VotingScreenState();
}

class _VotingScreenState extends State<VotingScreen> {
  bool checkBoxValue1 = false;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Scaffold(
        appBar: AppBar(),
        body: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "약속장소",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w400,
              ),
            ),
            // CheckboxListTile(
            //   title: const Text("수원시 영통구"),
            //   value: checkBoxValue1,
            //   onChanged: (bool? value) {
            //     setState(() {
            //       checkBoxValue1 = value!;
            //     });
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
