import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkTheme = false;

  // getter function
  bool get isDarktheme => _isDarkTheme;

  void toogletheme(bool newtheme) {
    _isDarkTheme = newtheme;
    notifyListeners();
  }
}
