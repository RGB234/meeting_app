import "package:flutter/material.dart";
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const GNav(
      gap: 4,
      tabs: [
        GButton(
          icon: Icons.home,
          text: "Home",
        ),
        GButton(
          icon: Icons.chat_outlined,
          text: "chat",
        ),
        GButton(
          icon: Icons.search,
          text: "Search",
        ),
        GButton(
          icon: Icons.favorite_outline,
          text: "Like",
        ),
      ],
    );
  }
}
