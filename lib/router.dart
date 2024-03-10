import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:meeting_app/features/authentication/repos/authentication_repo.dart';
import 'package:meeting_app/features/authentication/views/signin/signin_screen.dart';
import 'package:meeting_app/features/authentication/views/register/register_screen.dart';
import 'package:meeting_app/features/chat/views/chat_screen.dart';
import 'package:meeting_app/features/home/views/home_screen.dart';
import 'package:meeting_app/features/laboratory/test/riverpod_test_screen.dart';
import 'package:meeting_app/features/laboratory/videos/video_screen.dart';
import 'package:meeting_app/features/user_account/views/user_profile_screen.dart';

final routerProvider = Provider((ref) {
  // rebuild when authState has been changed;
  ref.watch(authState);
  return GoRouter(
    initialLocation: "/lobby",
    redirect: (context, state) {
      final location = state.matchedLocation;
      final isSignedIn = ref.watch(authRepo).isSignedIn;
      // exception handling for route "/";
      if (location == "/") return "/lobby";

      if (!isSignedIn) {
        if (location != "/lobby") {
          if (location == SigninScreen.routePath ||
              location == RegisterScreen.routePath) {
            return null;
          }
          return SigninScreen.routePath;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        name: SigninScreen.routeName,
        path: SigninScreen.routePath,
        builder: (context, state) {
          return const SigninScreen();
        },
      ),
      GoRoute(
        name: RegisterScreen.routeName,
        path: RegisterScreen.routePath,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: HomeScreen.routeName,
        path: "/:tab(home|myLobby|lobby|likes)",
        builder: (context, state) {
          final tab = state.pathParameters['tab']!;
          return HomeScreen(
            tab: tab,
          );
        },
      ),
      GoRoute(
        name: ChatScreen.routeName,
        path: ChatScreen.routePath,
        builder: (context, state) {
          final roomID = state.pathParameters['roomID']!;
          return ChatScreen(roomID: roomID);
        },
      ),
      GoRoute(
        name: ProfileScreen.routeName,
        path: ProfileScreen.routePath,
        builder: (context, state) => const ProfileScreen(),
      ),
      // Lab (test features)
      GoRoute(
        name: VideoScreen.routeName,
        path: VideoScreen.routePath,
        builder: (context, state) => const VideoScreen(),
      ),
      GoRoute(
        name: RiverpodTestScreen.routeName,
        path: RiverpodTestScreen.routePath,
        builder: (context, state) => const RiverpodTestScreen(),
      ),
    ],
  );
});
