import 'package:flutter/material.dart';
import 'package:pim_book/core/theme/text_themes.dart';

import 'color_themes.dart';

class PIMTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  bool get isDarkTheme => _isDarkTheme;


  static ThemeData lightTheme = ThemeData.from(
    colorScheme: ColorThemes.lightColorScheme,
  ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: ColorThemes.lightColorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        iconTheme: IconThemeData(
          size: 24,
          color: ColorThemes.lightColorScheme.onSurfaceVariant,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorThemes.lightColorScheme.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorThemes.lightColorScheme.primary,
          foregroundColor: ColorThemes.lightColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorThemes.lightColorScheme.primary,
          side: BorderSide(color: ColorThemes.lightColorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorThemes.lightColorScheme.primary,
        selectionColor: ColorThemes.lightColorScheme.primary,
        selectionHandleColor: ColorThemes.lightColorScheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: ColorThemes.lightColorScheme.onSurface.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorThemes.lightColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorThemes.lightColorScheme.primary),
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorThemes.lightColorScheme.onSurface,
      ),
      primaryIconTheme: IconThemeData(
        color: ColorThemes.lightColorScheme.primary,
      ),
      textTheme: TextThemes.lightTextTheme);

  static ThemeData darkTheme = ThemeData.from(
    colorScheme: ColorThemes.darkColorScheme,
  ).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleTextStyle: TextStyle(
          color: ColorThemes.darkColorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
        iconTheme: IconThemeData(
          size: 24,
          color: ColorThemes.darkColorScheme.onSurfaceVariant,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: ColorThemes.darkColorScheme.primary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorThemes.darkColorScheme.primary,
          foregroundColor: ColorThemes.darkColorScheme.onPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ColorThemes.darkColorScheme.primary,
          side: BorderSide(color: ColorThemes.darkColorScheme.primary),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: ColorThemes.darkColorScheme.primary,
        selectionColor: ColorThemes.darkColorScheme.primary,
        selectionHandleColor: ColorThemes.darkColorScheme.primary,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(
          color: ColorThemes.darkColorScheme.onSurface.withOpacity(0.5),
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: ColorThemes.darkColorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorThemes.darkColorScheme.primary),
        ),
      ),
      iconTheme: IconThemeData(
        color: ColorThemes.darkColorScheme.onSurface,
      ),
      primaryIconTheme: IconThemeData(
        color: ColorThemes.darkColorScheme.primary,
      ),
      textTheme: TextThemes.darkTextTheme,
  );
}
