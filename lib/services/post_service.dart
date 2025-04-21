import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:notes_maybank/models/api_response.dart';
import 'package:notes_maybank/utils/constant.dart';

Future<ApiResponse> getPost() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.get(Uri.parse(postUrl));

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
