import 'package:go_router/go_router.dart';
import 'package:meeting_app/features/authentication/login/email_login_screen.dart';
import 'package:meeting_app/features/authentication/login/login_screen.dart';
import 'package:meeting_app/features/authentication/signup/email_signup_screen.dart';
import 'package:meeting_app/features/authentication/signup/signup_screen.dart';
import 'package:meeting_app/features/chat/chat_screen.dart';
import 'package:meeting_app/features/home/home_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: HomeScreen.routeName,
      path: HomeScreen.routePath,
      builder: (context, state) => const HomeScreen(),
      routes: [
        GoRoute(
          name: LoginScreen.routeName,
          path: "login",
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              name: EmailLogInScreen.routeName,
              path: "email",
              builder: (context, state) => const EmailLogInScreen(),
            ),
          ],
        ),
        GoRoute(
          name: SignupScreen.routeName,
          path: SignupScreen.routePath,
          builder: (context, state) => const SignupScreen(),
          routes: [
            GoRoute(
              name: EmailSignUpScreen.routeName,
              path: EmailSignUpScreen.routePath,
              builder: (context, state) => const EmailSignUpScreen(),
            ),
          ],
        ),
        GoRoute(
          name: ChatScreen.routeName,
          path: ChatScreen.routeRoute,
          builder: (context, state) => const ChatScreen(),
        ),
        // Lab (test - features)
        GoRoute(
          name: VideoScreen.routeName,
          path: VideoScreen.routePath,
          builder: (context, state) => const VideoScreen(),
        ),
      ],
    ),
  ],
);
