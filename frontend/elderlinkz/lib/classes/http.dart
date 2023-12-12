import 'dart:convert';

import 'package:http/http.dart' as http;

class Http {

  static Future<Map<String, dynamic>> get(String socketAddress, String path) async {
    http.Response response = await http
      .get(Uri.http(socketAddress, "/data"),)
      .timeout(
        const Duration(seconds: 10),
        onTimeout: () => http.Response('{"error":"The connection has timed out"}', 408)
      );

    return json.decode(response.body);
  }

}