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
}
