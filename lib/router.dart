import 'package:go_router/go_router.dart';
import 'package:meeting_app/features/authentication/login/email_login_screen.dart';
import 'package:meeting_app/features/authentication/login/login_screen.dart';
import 'package:meeting_app/features/authentication/signup/email_signup_screen.dart';
import 'package:meeting_app/features/authentication/signup/signup_screen.dart';
import 'package:meeting_app/features/home/home_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: LoginScreen.routeName,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: EmailLogInScreen.routeName,
      builder: (context, state) => const EmailLogInScreen(),
    ),
    GoRoute(
      path: SignupScreen.routeName,
      builder: (context, state) => const SignupScreen(),
    ),
    GoRoute(
      path: EmailSignUpScreen.routeName,
      builder: (context, state) => const EmailSignUpScreen(),
    ),
    GoRoute(
      path: VideoScreen.routeName,
      builder: (context, state) => const VideoScreen(),
    ),
  ],
);
