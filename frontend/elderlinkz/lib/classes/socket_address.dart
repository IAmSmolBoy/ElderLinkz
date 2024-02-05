import 'package:flutter/material.dart';

class SocketAddress extends ChangeNotifier {
  SocketAddress({ this.socketAddress = "10.0.2.2:3000" });

  String socketAddress;

  void setNewSocketAddress(String newSocketAddress) async {
    socketAddress = newSocketAddress;
    notifyListeners();
  }

}