import 'dart:convert';

import 'package:http/http.dart' as http;

class BotApi {
  Future<Map> fetchBotMessage() async {
    var client = http.Client();

    try {
      final response = await client.get(
          Uri.parse(
              "https://my-json-server.typicode.com/tryninjastudy/dummyapi/db"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          });

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map;
      } else {
        throw "Something went wrong";
      }
    } catch (e) {
      throw "Something went wrong";
    }
  }
}
