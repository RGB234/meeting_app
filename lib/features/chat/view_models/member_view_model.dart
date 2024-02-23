import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meeting_app/features/chat/repos/member_repo.dart';
import 'package:meeting_app/features/user_account/models/user_profile_model.dart';

class MemberViewModel
    extends AutoDisposeFamilyAsyncNotifier<List<UserProfileModel>, String> {
  late MemberRepository _memberRepo;
  late List<UserProfileModel> _members;
  @override
  FutureOr<List<UserProfileModel>> build(arg) async {
    state = const AsyncValue.loading();
    _memberRepo = ref.read(memberRepo);
    state = await AsyncValue.guard(() async {
      _members = await _memberRepo.getListOfMembersIn(roomid: arg);
      return _members;
    });
    //
    _members.map((e) => print("username ::" + e.username));
    //
    return _members;
  }

  // return [current male user count, current female user]
  List<int> countMembers() {
    int male = 0;
    int female = 0;
    _members.map((member) {
      //
      print("gender >>" + member.gender);
      //
      if (member.gender == 'male') {
        male++;
      } else if (member.gender == 'female') {
        female++;
      } else {
        throw 'another type of gender(which is Not male or female)';
      }
    });
    return [male, female];
  }

  int countMale() {
    return countMembers().elementAt(0);
  }

  int countFemale() {
    return countMembers().elementAt(1);
  }
}

final memberProvider = AutoDisposeFamilyAsyncNotifierProvider<MemberViewModel,
    List<UserProfileModel>, String>(
  () => MemberViewModel(),
);
