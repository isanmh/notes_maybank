import 'package:flutter/material.dart';
import 'package:notes_maybank/navigations/google_nav_bar.dart';
import 'package:notes_maybank/pages/notes_module/add_note.dart';

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
          '/': (context) => const GoogleNavBar(),
          '/add': (context) => const AddNote(),
        },
        // home: GoogleNavBar(),
      ),
    );
  }
}
