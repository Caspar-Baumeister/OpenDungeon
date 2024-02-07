import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> startApi() async {
  final url = Uri.parse('http://3.78.82.23:5000/start');

  final response =
      await http.post(url, headers: {'Accept': 'application/json'});

  if (response.statusCode == 200) {
    // Parse the JSON response if the request was successful.
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    return {"error": true};
  }
}
