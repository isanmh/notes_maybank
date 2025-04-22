import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes_maybank/models/notes.model.dart';
import 'package:notes_maybank/utils/constant.dart';

class NotesService {
  // get all notes
  Future getData() async {
    try {
      final response = await http.get(Uri.parse(notesUrl));
      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Notes> notes = it.map((e) => Notes.fromJson(e)).toList();
        return notes;
      } else {
        print("Error: ${response.statusCode}");
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // post notes
  Future addData(String title, String content) async {
    try {
      final response = await http.post(
        Uri.parse(notesUrl),
        body: {"title": title, "content": content},
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // update notes
  Future updateData(String id, String title, String content) async {
    try {
      final response = await http.put(
        Uri.parse(notesUrl + "/" + id),
        body: {"title": title, "content": content},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // delete notes
  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(notesUrl + "/" + id));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
