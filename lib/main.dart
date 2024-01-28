// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/router.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    const ProviderScope(
      child: MeetingApp(),
    ),
  );
}

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: "Test",
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: const Color.fromARGB(255, 208, 195, 255),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.black,
            backgroundColor: Color.fromARGB(255, 208, 195, 255),
            elevation: 0,
            titleTextStyle: TextStyle(
              fontSize: Sizes.size16,
              fontWeight: FontWeight.w300,
            )),
      ),
      // Navigator version 1
      // initialRoute: HomeScreen.routeName,
      // routes: {
      //   HomeScreen.routeName: (context) => const HomeScreen(),
      //   LoginScreen.routeName: (context) => const LoginScreen(),
      //   EmailLogInScreen.routeName: (context) => const EmailLogInScreen(),
      //   SignupScreen.routeName: (context) => const SignupScreen(),
      //   EmailSignUpScreen.routeName: (context) => const EmailSignUpScreen(),
      //   VideoScreen.routeName: (context) => const VideoScreen(),
      // },
    );
  }
}
