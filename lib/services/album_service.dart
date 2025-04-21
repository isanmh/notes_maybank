import 'dart:convert';

import 'package:notes_maybank/models/album_model.dart';
import 'package:http/http.dart' as http;
import 'package:notes_maybank/models/api_response.dart';
import 'package:notes_maybank/utils/constant.dart';

Future<ApiResponse> getAlbum() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse(albumUrl));

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body);
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors.toString();
        break;
      default:
        apiResponse.error = 'Error: ${response.statusCode}';
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }
  return apiResponse;
}

Future<Album> fetchAlbum() async {
  final response = await http.get(
    Uri.parse('https://jsonplaceholder.typicode.com/albums/1'),
  );

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
  } else {
    throw Exception('Failed to load album');
  }
}
