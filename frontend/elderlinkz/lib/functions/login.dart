import 'package:elderlinkz/classes/http.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

Future<String?> login({
  required Http httpClient,
  required LoginData credentials,
  Future<String?> Function(Map<String, dynamic>)? onSuccess,
  String? Function(Map<String, dynamic>)? onError,
  String? Function()? onUnknownError,
}) async {

  onUnknownError ??= () => "An error has occurred";

  try {
    
    // Login with saved credentials
    Map<String, dynamic> loginBody = await httpClient.post(
      path: "/elderlinkz/login",
      body: {
        "name": credentials.name.toLowerCase(),
        "password": credentials.password
      }
    );
    // Map<String, dynamic> loginBody = { "message": "Success" };
      
    if (onSuccess != null) {
    // if (loginBody.containsKey("message") && loginBody["message"] == "Success" && onSuccess != null) {
      return onSuccess(loginBody);
    }
    else if (loginBody.containsKey("error") && loginBody["error"] != null) {
      onError ??= (loginBody) => loginBody["error"];

      return onError(loginBody);
    }
    else {
      debugPrint("${loginBody}");
      return onUnknownError();
    }

  } catch (e) {
      debugPrint("${e}");
    return onUnknownError();
    
  }

}