import 'package:flutter/material.dart';
import 'package:notes_maybank/services/notes_service.dart';
import 'package:notes_maybank/utils/constant.dart';

class EditNote extends StatefulWidget {
  const EditNote({super.key});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  NotesService notesService = NotesService();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  // validasi
  bool validateTitle = false;
  bool validateContent = false;

  @override
  Widget build(BuildContext context) {
    // ambil data dari arguments
    final args = ModalRoute.of(context)!.settings.arguments as List<String>;

    // jika error args
    // final args =
    //     (ModalRoute.of(context)!.settings.arguments as List<String>).toList();

    // final args =
    //     (ModalRoute.of(context)!.settings.arguments as List<String?>).toList();

    // if (args.isNotEmpty) {
    //   titleController.text = args[1] ?? "";
    //   contentController.text = args[2] ?? "";
    // }

    if (args.isNotEmpty) {
      titleController.text = args[1];
      contentController.text = args[2];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Note"),
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
                    bool response = await notesService.updateData(
                      args[0], // id
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
                      showSnackBar(context, "Failed to update note");
                    }
                  }
                },
                child: Text("Update Note"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
