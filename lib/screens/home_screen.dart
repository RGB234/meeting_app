import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Connection(가제)",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: const Color.fromRGBO(185, 168, 248, 1),
        elevation: 8,
      ),
      drawer: const NavigationDrawer(),
      bottomNavigationBar: const GNav(
        gap: 8,
        tabs: [
          GButton(
            icon: Icons.home,
            text: "Home",
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
      ),
    );
  }
}

// 나중에 따로 .dart 로 분리할 예정. sidebar
class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildMenuItems(context),
        ],
      )),
    );
  }
}

// 나중에 별도 .dart 로 분리할 예정.
Widget buildMenuItems(BuildContext context) => Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text('내 정보'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.assignment),
          title: const Text('기록'),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: const Text('환경설정'),
          onTap: () {},
        )
      ],
    );
