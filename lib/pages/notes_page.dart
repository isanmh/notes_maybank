import 'package:flutter/material.dart';
import 'package:notes_maybank/models/notes.model.dart';
import 'package:notes_maybank/services/notes_service.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  List<Notes> _listNotes = [];
  NotesService notesService = NotesService();
  bool isLoading = true;

  show() async {
    _listNotes = await notesService.getData();
    setState(() {
      isLoading = false;
      _listNotes = _listNotes;
    });
  }

  @override
  void initState() {
    super.initState();
    show();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_box),
            onPressed: () {
              // Add your action here
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _listNotes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(
                _listNotes[index].title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                _listNotes[index].content,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () async {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Delete Note"),
                        content: Text("Are you sure?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("Cancel"),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
