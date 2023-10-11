// ignore_for_file: unused_field

import 'package:changebackgrond_frontend/values/values.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const _lightFillColor = Colors.black;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      iconTheme: const IconThemeData(color: AppColors.white),
      canvasColor: colorScheme.background,
      appBarTheme: const AppBarTheme(
        color: AppColors.primaryColor,
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: AppColors.black,
        selectionColor: AppColors.secondaryColor,
        selectionHandleColor: AppColors.secondaryColor,
      ),
      scaffoldBackgroundColor: colorScheme.background,
      highlightColor: Colors.transparent,
      focusColor: AppColors.primaryColor,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.primaryColor,
    secondary: AppColors.secondaryColor,
    background: AppColors.primaryColor,
    surface: AppColors.primaryColor,
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xCC88A67B),
    onSurface: Color(0xFF4C7241),
    brightness: Brightness.light,
  );

  static const _bold = FontWeight.w700;
  static const _semiBold = FontWeight.w500;
  static const _medium = FontWeight.w400;
  static const _regular = FontWeight.w300;
  static const _semiLight = FontWeight.w200;
  static const _light = FontWeight.w100;

  static final TextTheme _textTheme = TextTheme(
    titleMedium: TextStyle(
      fontFamily: StringConst.Oswald,
      fontSize: Sizes.TEXT_SIZE_36,
      color: AppColors.grey700,
      fontWeight: _regular,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: TextStyle(
      fontFamily: StringConst.Oswald,
      fontSize: Sizes.TEXT_SIZE_22,
      color: AppColors.grey700,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
    bodySmall: TextStyle(
      fontFamily: StringConst.Quicksand,
      fontSize: Sizes.TEXT_SIZE_22,
      color: AppColors.black,
      fontWeight: _light,
      fontStyle: FontStyle.normal,
    ),
  );
}
