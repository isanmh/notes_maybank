import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:notes_maybank/pages/ai_image_generator.dart';
import 'package:notes_maybank/pages/album_api.dart';
import 'package:notes_maybank/pages/notes_page.dart';
import 'package:notes_maybank/pages/post_page.dart';
import 'package:notes_maybank/pages/user_page.dart';

class GoogleNavBar extends StatefulWidget {
  const GoogleNavBar({super.key});

  @override
  State<GoogleNavBar> createState() => _GoogleNavBarState();
}

class _GoogleNavBarState extends State<GoogleNavBar> {
  int currentPage = 0;
  List<Widget> pages = [
    NotesPage(),
    PostPage(),
    AlbumApi(),
    UserPage(),
    AiImageGenerator(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GNav(
            gap: 8,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.deepPurple.shade800,
            padding: EdgeInsets.all(16),
            tabBorderRadius: 30,
            curve: Curves.easeInOut,
            tabBackgroundGradient: LinearGradient(
              colors: [Color(0xFF66145F), Colors.deepPurpleAccent],
            ),
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            haptic: true,
            tabs: [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.newspaper, text: 'News'),
              GButton(icon: Icons.album, text: 'Album'),
              GButton(icon: Icons.person, text: 'Profile'),
              GButton(icon: Icons.chat, text: 'Chat AI'),
            ],
            onTabChange: (index) {
              setState(() {
                currentPage = index;
              });
            },
          ),
        ),
      ),
      body: pages[currentPage],
    );
  }
}
