// http_helper.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> getRequest(Uri url) async {
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to load data from $url');
  }
}
