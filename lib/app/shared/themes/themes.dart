import 'package:flutter/material.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      elevatedButtonTheme: _defaultElevatedButtonTheme,
      floatingActionButtonTheme: _defaultFloatingActionButtonTheme,
      inputDecorationTheme: _defaultInputDecoration,
    );

ThemeData get darkTheme => lightTheme;

// ThemeData get darkTheme => ThemeData(
//       useMaterial3: true,
//       elevatedButtonTheme: _defaultElevatedButtonTheme,
//       floatingActionButtonTheme: _defaultFloatingActionButtonTheme,
//       inputDecorationTheme: _defaultInputDecoration,
//     );

final class AppColors {
  static const white = Colors.white;
  static const black = Colors.black;
  static const transparent = Colors.transparent;
  static const lightPrimary = Color(0xFFA5A5A5);
  static const darkPrimary = Color(0xFF696969);
  static const secondaryBlack = Color(0xFF333333);
  static const errorColor = Colors.red;
  static const checkColor = Colors.green;
}

OutlineInputBorder get _defautInputBorder => OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: AppColors.darkPrimary, width: 1.5),
    );

InputDecorationTheme get _defaultInputDecoration => InputDecorationTheme(
      filled: true,
      fillColor: AppColors.white,
      labelStyle: const TextStyle(
        color: AppColors.darkPrimary,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
      floatingLabelStyle: const TextStyle(
        color: AppColors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      enabledBorder: _defautInputBorder,
      focusedBorder: _defautInputBorder.copyWith(
        borderSide: const BorderSide(color: AppColors.black, width: 1.5),
      ),
      errorBorder: _defautInputBorder.copyWith(
        borderSide: const BorderSide(color: Colors.red),
      ),
      border: _defautInputBorder,
    );

FloatingActionButtonThemeData get _defaultFloatingActionButtonTheme =>
    const FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkPrimary,
      foregroundColor: AppColors.white,
    );

ElevatedButtonThemeData get _defaultElevatedButtonTheme =>
    ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(4),
        backgroundColor: MaterialStateProperty.all(AppColors.black),
        foregroundColor: MaterialStateProperty.all(AppColors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 18,
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

final class AppTextStyle {
  static const titleStyle = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w900,
  );

  static const titleSmallStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const subtitleStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );
}
