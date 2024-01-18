import 'package:firebase_core/firebase_core.dart';
import 'package:meeting_app/features/authentication/login/email_login_screen.dart';
import 'package:meeting_app/features/authentication/login/login_screen.dart';
import 'package:meeting_app/features/authentication/signup/email_signup_screen.dart';
import 'package:meeting_app/features/authentication/signup/signup_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:meeting_app/constants/sizes.dart';
import 'package:meeting_app/features/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MeetingApp());
}

class MeetingApp extends StatelessWidget {
  const MeetingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        EmailLogInScreen.routeName: (context) => const EmailLogInScreen(),
        SignupScreen.routeName: (context) => const SignupScreen(),
        EmailSignUpScreen.routeName: (context) => const EmailSignUpScreen(),
        VideoScreen.routeName: (context) => const VideoScreen(),
      },
    );
  }
}
