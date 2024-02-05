import 'package:flutter/material.dart';

class NavbarSelected extends ChangeNotifier {
  NavbarSelected({ this.index = 0 });

  int index;

  void setSelected(int newIndex) async {
    index = newIndex;
    notifyListeners();
  }

}