import 'package:flutter/material.dart';



class ThemeNotifier with ChangeNotifier {
  // ThemeMode themeMode=ThemeMode.system;
  ThemeMode _themeMode;

  ThemeNotifier(this._themeMode);

  getThemeMode() => _themeMode;

  setThemeMode(ThemeMode themeMode) async {
    _themeMode = themeMode;
    notifyListeners();
  }
}