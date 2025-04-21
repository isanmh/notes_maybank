import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes_maybank/models/user_model.dart';
import 'package:notes_maybank/utils/constant.dart';

class UserService {
  // fungsi untuk manggil api dari reqres.in
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(reqUrl));

    if (response.statusCode == 200) {
      // cara pertama
      final List<User> users =
          jsonDecode(
            response.body,
          )['data'].map<User>((json) => User.fromJson(json)).toList();

      // cara kedua
      // final result = jsonDecode(response.body);
      // List<User> users = List<User>.from(
      //   result['data'].map((user) => User.fromJson(user)),
      // );

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }
}
