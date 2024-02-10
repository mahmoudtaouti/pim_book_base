import 'package:flutter/material.dart';

import 'color_themes.dart';

class TextThemes{

  static final lightTextTheme = TextTheme(
    bodyLarge: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w200,
      fontSize: 12,
    ),

    displayLarge: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 34,
    ),
    displayMedium: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    displaySmall: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    headlineLarge: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 45,
    ),
    headlineMedium: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 32,
    ),
    headlineSmall: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 23,
    ),

    titleLarge: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    titleSmall: TextStyle(
      color: ColorThemes.lightColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 13,
    ),

    labelLarge: TextStyle(
      color: ColorThemes.lightColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      color: ColorThemes.lightColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      color: ColorThemes.lightColorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    ),
  );

  static final darkTextTheme = TextTheme(
    bodyLarge: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyMedium: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    bodySmall: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w200,
      fontSize: 12,
    ),

    displayLarge: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 34,
    ),
    displayMedium: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w700,
      fontSize: 24,
    ),
    displaySmall: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 20,
    ),

    headlineLarge: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 20,
    ),
    headlineMedium: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 16,
    ),
    headlineSmall: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w300,
      fontSize: 14,
    ),

    titleLarge: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 18,
    ),
    titleMedium: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 15,
    ),
    titleSmall: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),

    labelLarge: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 14,
    ),
    labelMedium: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 12,
    ),
    labelSmall: TextStyle(
      color: ColorThemes.darkColorScheme.onSurface,
      fontWeight: FontWeight.w600,
      fontSize: 10,
    ),
  );
}