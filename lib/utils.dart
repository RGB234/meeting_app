import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void showFirebaseErrorSnack(BuildContext context, Object? err) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text((err as FirebaseAuthException).message ?? "Invalid value"),
    ),
  );
}

void showErrorSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      showCloseIcon: true,
      content: Text(message),
    ),
  );
}

class AuthenticationValidator {
  static String? isUsernameValid({required String? value}) {
    if (value == null) {
      return null;
    }
    final regExp = RegExp(r"[ㄱ-ㅎㅏ-ㅣ가-힣a-z0-9A-Z]{1,12}");
    if (regExp.hasMatch(value) && value.length < 13) {
      return null;
    } else if (value.isEmpty) {
      return "빈 칸을 채워야 합니다.";
    } else {
      return "1~12자리";
    }
  }

  static String? isEmailValid({required String? value}) {
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

  static String? isPasswordValid({required String? value}) {
    if (value == null) {
      return null;
    }
    final regExp = RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,20}$");
    if (regExp.hasMatch(value) && value.length < 17) {
      return null;
    } else if (value.isEmpty) {
      return "빈 칸을 채워야 합니다.";
    } else {
      return "최소 8자리 - 최대 20자리. 대문자, 소문자, 숫자 각각 최소 1개";
    }
  }
}
