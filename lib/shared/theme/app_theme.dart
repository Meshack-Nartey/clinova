import 'package:flutter/material.dart';

const _seed = Color(0xFF1A5276); // deep navy — trustworthy / medical

final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  inputDecorationTheme: const InputDecorationTheme(
    border: OutlineInputBorder(),
    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16),
    bodyMedium: TextStyle(fontSize: 15),
    labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size.fromHeight(52),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
  ),
);
