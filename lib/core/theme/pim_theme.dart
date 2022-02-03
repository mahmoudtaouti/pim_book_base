import 'package:flutter/material.dart';


class PIMTheme with ChangeNotifier {
  //TODO : change default theme
  static bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  bool get isDarkTheme => _isDarkTheme;

  //get light theme
  static ThemeData get lightTheme {
    return ThemeData.light();}

  //get dark theme
  static ThemeData get darkTheme {
    return ThemeData.dark();
  }
}
