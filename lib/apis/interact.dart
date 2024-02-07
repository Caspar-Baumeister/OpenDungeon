import 'dart:convert';

import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> interactApi(String option) async {
  final url = Uri.parse('http://3.78.82.23:5000/interact');

  final response = await http.post(url,
      body: jsonEncode({"option": option}),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      });

  if (response.statusCode == 200) {
    // Parse the JSON response if the request was successful.
    final Map<String, dynamic> data = jsonDecode(response.body);
    return data;
  } else {
    return {"error": true};
  }
}
