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
