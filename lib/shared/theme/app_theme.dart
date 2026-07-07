import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme.light(
    primary:              Color(0xFF111111),
    onPrimary:            Color(0xFFFFFFFF),
    primaryContainer:     Color(0xFFF2F2F2),
    onPrimaryContainer:   Color(0xFF111111),
    secondary:            Color(0xFF444444),
    onSecondary:          Color(0xFFFFFFFF),
    secondaryContainer:   Color(0xFFEEEEEE),
    onSecondaryContainer: Color(0xFF222222),
    surface:              Color(0xFFFFFFFF),
    onSurface:            Color(0xFF111111),
    surfaceContainerLow:  Color(0xFFF8F8F8),
    surfaceContainer:     Color(0xFFF4F4F4),
    surfaceContainerHigh: Color(0xFFEEEEEE),
    surfaceContainerHighest: Color(0xFFE8E8E8),
    outline:              Color(0xFFBBBBBB),
    outlineVariant:       Color(0xFFE4E4E4),
    error:                Color(0xFFB00020),
    onError:              Color(0xFFFFFFFF),
    shadow:               Color(0xFF000000),
    scrim:                Color(0xFF000000),
  ),

  appBarTheme: const AppBarTheme(
    centerTitle: false,
    elevation: 0,
    scrolledUnderElevation: 1,
    backgroundColor: Color(0xFFFFFFFF),
    foregroundColor: Color(0xFF111111),
    surfaceTintColor: Colors.transparent,
    shadowColor: Color(0x14000000),
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    titleTextStyle: TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w700,
      color: Color(0xFF111111),
      letterSpacing: -0.2,
    ),
  ),

  cardTheme: CardThemeData(
    elevation: 0,
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0xFFEEEEEE)),
    ),
    clipBehavior: Clip.antiAlias,
    margin: EdgeInsets.zero,
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: const Color(0xFFF4F4F4),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF111111), width: 1.5),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB00020), width: 1),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFFB00020), width: 1.5),
    ),
    labelStyle: const TextStyle(color: Color(0xFF787878)),
    hintStyle: const TextStyle(color: Color(0xFFAAAAAA)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF111111),
      foregroundColor: Colors.white,
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        letterSpacing: 0,
      ),
      elevation: 0,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF111111),
      side: const BorderSide(color: Color(0xFFDDDDDD)),
      minimumSize: const Size.fromHeight(52),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      textStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
  ),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF111111),
    foregroundColor: Colors.white,
    elevation: 2,
    shape: StadiumBorder(),
  ),

  listTileTheme: const ListTileThemeData(
    iconColor: Color(0xFF444444),
    titleTextStyle: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: Color(0xFF111111),
    ),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFEEEEEE),
    thickness: 1,
    space: 1,
  ),

  iconButtonTheme: IconButtonThemeData(
    style: IconButton.styleFrom(foregroundColor: const Color(0xFF444444)),
  ),

  chipTheme: ChipThemeData(
    backgroundColor: const Color(0xFFF2F2F2),
    labelStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w600,
      color: Color(0xFF444444),
    ),
    side: BorderSide.none,
    shape: const StadiumBorder(),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  ),

  scaffoldBackgroundColor: const Color(0xFFF8F8F8),

  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, letterSpacing: -0.5, color: Color(0xFF111111)),
    headlineMedium: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, letterSpacing: -0.3, color: Color(0xFF111111)),
    titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF111111)),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF111111)),
    bodyLarge: TextStyle(fontSize: 16, color: Color(0xFF222222)),
    bodyMedium: TextStyle(fontSize: 14, color: Color(0xFF444444)),
    bodySmall: TextStyle(fontSize: 12, color: Color(0xFF787878)),
    labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
  ),
);
