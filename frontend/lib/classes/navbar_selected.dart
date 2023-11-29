import 'package:flutter/material.dart';

class NavbarSelected extends ChangeNotifier {
  int index;

  NavbarSelected({ this.index = 0 });

  void setSelected(int newIndex ) async {
    index = newIndex;
    notifyListeners();
  }

}