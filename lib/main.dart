import 'package:flutter/material.dart';
import 'package:notes_maybank/navigations/google_nav_bar.dart';
import 'package:notes_maybank/pages/notes_module/add_note.dart';
import 'package:notes_maybank/pages/notes_module/edit_note.dart';
import 'package:notes_maybank/pages/notes_page.dart';
import 'package:notes_maybank/pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/nav': (context) => const GoogleNavBar(),
          '/add': (context) => const AddNote(),
          '/edit': (context) => const EditNote(),
          '/note': (context) => const NotesPage(),
        },
        // home: GoogleNavBar(),
      ),
    );
  }
}
