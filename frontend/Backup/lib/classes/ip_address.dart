import 'package:flutter/material.dart';

class IpAddress extends ChangeNotifier {
  IpAddress({ this.ip = "10.0.2.2:3000" });

  String ip;

  void setSelected(String newIp) async {
    ip = newIp;
    notifyListeners();
  }

}