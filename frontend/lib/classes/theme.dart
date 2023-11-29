import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  ThemeProvider({ this.themeMode = ThemeMode.light });

  void setThemeMode({ required ThemeMode newTheme }) async {
    themeMode = newTheme;
    notifyListeners();
  }

}