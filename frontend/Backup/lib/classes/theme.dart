import 'package:flutter/material.dart';
import 'package:elderlinkz/globals.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode;

  ThemeProvider({ this.themeMode = ThemeMode.light });

  void setThemeMode({ required ThemeMode newTheme }) async {
    themeMode = newTheme;

    prefs.setBool("lightMode", newTheme == ThemeMode.light);

    notifyListeners();
  }

}