import 'package:flutter/material.dart';
import 'package:notes_maybank/services/notes_service.dart';
import 'package:notes_maybank/utils/constant.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  NotesService notesService = NotesService();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  // validasi
  bool validateTitle = false;
  bool validateContent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Note"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  hintText: 'Title',
                  errorText: validateTitle ? "Title required" : null,
                ),
                controller: titleController,
              ),
              TextField(
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Content',
                  errorText: validateContent ? "Content required" : null,
                ),
                controller: contentController,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  setState(() {
                    titleController.text.isEmpty
                        ? validateTitle = true
                        : validateTitle = false;
                    contentController.text.isEmpty
                        ? validateContent = true
                        : validateContent = false;
                  });
                  // validasi jika benar
                  if (validateTitle == false && validateContent == false) {
                    bool response = await notesService.addData(
                      titleController.text,
                      contentController.text,
                    );
                    if (response) {
                      showSnackBar(context, "Note added successfully");
                      // Navigator.pop(context);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        "/",
                        (route) => false,
                      );
                    } else {
                      showSnackBar(context, "Failed to add note");
                    }
                  }
                },
                child: Text("Add Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
