import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/router.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    const ProviderScope(
      child: MeetingApp(),
    ),
  );
}

class MeetingApp extends ConsumerWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      routerConfig: ref.watch(routerProvider),
      debugShowCheckedModeBanner: false,
      title: "Test",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        // french marrigold color()
        primaryColor: const Color.fromRGBO(252, 148, 56, 1),
        appBarTheme: const AppBarTheme(
            // foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w300,
            )),
      ),
    );
  }
}
