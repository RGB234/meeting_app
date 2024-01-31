import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/authentication/screens/login/login_screen.dart';
import 'package:meeting_app/features/authentication/screens/signup/signup_screen.dart';
import 'package:meeting_app/features/chat/chat_screen.dart';
import 'package:meeting_app/features/home/home_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/explore",
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (location != "/explore") {
          if (location == LoginScreen.routePath ||
              location == SignupScreen.routePath) {
            return null;
          }
          return LoginScreen.routePath;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: LoginScreen.routeName,
        path: LoginScreen.routePath,
        builder: (context, state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        name: SignupScreen.routeName,
        path: SignupScreen.routePath,
        builder: (context, state) => const SignupScreen(),
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: "/:tab(home|chat|explore|likes)",
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return HomeScreen(
            tab: tab,
          );
        },
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
});
