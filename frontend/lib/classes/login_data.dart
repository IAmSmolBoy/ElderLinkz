import 'package:flutter/material.dart';

class LoginData extends ChangeNotifier {
  LoginData({
    this.id = 0,
    this.password = ""
  });

  int id;
  String password;

  void setId(int newId) async {
    id = newId;
    notifyListeners();
  }

  void setPassword(String newPassword) async {
    password = newPassword;
    notifyListeners();
  }

}