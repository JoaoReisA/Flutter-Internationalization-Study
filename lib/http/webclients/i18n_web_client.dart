import 'dart:convert';

import 'package:http/http.dart';

import '../webclient.dart';

const MESSAGES_URI =
    "https://gist.githubusercontent.com/JoaoReisA/28ec4d9b3aba7a3120d4e4e0587f738a/raw/0050c61e7a8d55887ce2dd470e8c5e99792ee25e/";

class I18NWebClient {
  final String viewKey;

  I18NWebClient(this.viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response = await client.get("$MESSAGES_URI$viewKey.json");
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
