import 'dart:convert';

import 'package:http/http.dart' as http;

int timeoutSec = 5;

class Http {

  const Http({
    required this.socketAddress,
  });

  final String socketAddress;

  Future<dynamic> get({
    required String path,
  }) async {
    http.Response response = await http
      .get(Uri.http(socketAddress, path),)
      .timeout(
        Duration(seconds: timeoutSec),
        onTimeout: () => http.Response('{"error":"The connection has timed out"}', 408)
      );

      try {
        return json.decode(response.body);
      } catch (e){
        print(response.body);
        
        return { "error": "An Error has occurred" };
      }
  }

  Future<dynamic> post({
    required String path,
    Object? body
  }) async {
    http.Response response = await http
      .post(
        Uri.http(socketAddress, path),
        body: body,
      )
      .timeout(
        Duration(seconds: timeoutSec),
        onTimeout: () => http.Response('{"error":"The connection has timed out"}', 408)
      );

      try {
        return json.decode(response.body);
      } catch (e){
        print(response.body);
        
        return { "error": "An Error has occurred" };
      }
  }

}