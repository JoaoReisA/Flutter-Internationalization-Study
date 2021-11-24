
import 'dart:convert';

import 'package:http/http.dart' as client;
import 'package:http/http.dart';

const MESSAGES_URI = "https://gist.githubusercontent.com/JoaoReisA/28ec4d9b3aba7a3120d4e4e0587f738a/raw/1cf054d1a31f6af18e713614a4bb4a422e576276/i18n.json";
class I18NWebClient {
  Future<Map<String,String>> findAll() async {
    final Response response =
    await client.get(MESSAGES_URI);
    final Map<String,String> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }


}