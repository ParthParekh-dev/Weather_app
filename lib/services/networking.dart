import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});

  final Uri url;

  Future getJsonData() async {
    http.Response response = await http.get(url);
    String data = response.body;

    if (response.statusCode == 200) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }
}
