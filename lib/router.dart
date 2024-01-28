import 'package:go_router/go_router.dart';
import 'package:meeting_app/features/authentication/login/email_login_screen.dart';
import 'package:meeting_app/features/authentication/login/login_screen.dart';
import 'package:meeting_app/features/authentication/signup/email_signup_screen.dart';
import 'package:meeting_app/features/authentication/signup/signup_screen.dart';
import 'package:meeting_app/features/chat/chat_screen.dart';
import 'package:meeting_app/features/home/home_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';

final router = GoRouter(
  initialLocation: "/explore",
  routes: [
    // GoRoute(
    //   path: "/home",
    //   builder: (context, state) => const HomeScreen(tab: "home"),
    //   routes: [
    //     GoRoute(
    //       name: LoginScreen.routeName,
    //       path: LoginScreen.routePath,
    //       builder: (context, state) => const LoginScreen(),
    //       routes: [
    //         GoRoute(
    //           name: EmailLogInScreen.routeName,
    //           path: EmailLogInScreen.routePath,
    //           builder: (context, state) => const EmailLogInScreen(),
    //         ),
    //       ],
    //     ),
    //     GoRoute(
    //       name: SignupScreen.routeName,
    //       path: SignupScreen.routePath,
    //       builder: (context, state) => const SignupScreen(),
    //       routes: [
    //         GoRoute(
    //           name: EmailSignUpScreen.routeName,
    //           path: EmailSignUpScreen.routePath,
    //           builder: (context, state) => const EmailSignUpScreen(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
    GoRoute(
      name: HomeScreen.routeName,
      path: "/:tab(home|chat|explore|likes)",
      builder: (context, state) {
        final tab = state.pathParameters['tab']!;
        return HomeScreen(
          tab: tab,
        );
      },
      routes: [
        GoRoute(
          name: LoginScreen.routeName,
          path: LoginScreen.routePath,
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              name: EmailLogInScreen.routeName,
              path: EmailLogInScreen.routePath,
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
      ],
    ),
    GoRoute(
      name: ChatScreen.routeName,
      path: ChatScreen.routeRoute,
      builder: (context, state) {
        final chatId = state.pathParameters['chatId']!;
        return ChatScreen(chatId: chatId);
      },
    ),
    // Lab (test features)
    GoRoute(
      name: VideoScreen.routeName,
      path: VideoScreen.routePath,
      builder: (context, state) => const VideoScreen(),
    ),
  ],
);
