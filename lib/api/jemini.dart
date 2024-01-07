import 'dart:convert';

import 'package:http/http.dart' as http;

class GeminiApi {
  static Future<Map<String, String>> getHeader() async {
    return {
      "Content-Type": "application/json",
    };
  }

  // create http request
  static Future<String> getGeminiData(text) async {
    try {
      final header = await getHeader();

      final Map<String, dynamic> requestBody = {
        'contents': [
          {
            'parts': [
              {'text': text}
            ]
          }
        ],
        'generation_config': {
          "temperature": 0.9,
          "top_p": 1,
          "top_k": 1,
          "max_output_tokens": 2048,
        }
      };

      String url =
          'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCv5ANWHWaCTDACD2Ge2ouUmPYyO5gBmsQ';

      var response = await http.post(Uri.parse(url),
          headers: header, body: jsonEncode(requestBody));

      print(response.body);

      if (response.statusCode == 200) {
        var jsonRespose = jsonDecode(response.body) as Map<String, dynamic>;
        return jsonRespose['candidates'][0]['content']['parts'][0]['text'];
      } else {
        return "Error candidates";
      }
    } catch (e) {
      return "Error";
    }
  }
}
