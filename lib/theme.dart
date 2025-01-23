import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2196F3);
const appBarTheme = AppBarTheme(
  iconTheme: IconThemeData(
    color: Colors.white,
  ),
  backgroundColor: primaryColor,
  scrolledUnderElevation: 0,
  titleTextStyle: TextStyle(
    color: Colors.white,
    fontSize: 24,
  ),
);

final buttonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
  ),
);

final colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  secondary: Colors.deepPurple,
);

ThemeData themeData = ThemeData.light().copyWith(
  primaryColor: primaryColor,
  colorScheme: colorScheme,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: buttonTheme,
);

final darkColorScheme = ColorScheme.fromSeed(
  seedColor: Colors.deepPurple,
  brightness: Brightness.dark,
  secondary: Colors.deepPurpleAccent,
);

ThemeData darkThemeData = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  colorScheme: darkColorScheme,
  appBarTheme: appBarTheme.copyWith(
    backgroundColor: Colors.black,
    titleTextStyle: const TextStyle(
      color: Colors.white,
      fontSize: 24,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.grey[800],
      foregroundColor: Colors.white,
    ),
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: Colors.grey[900],
    modalBackgroundColor: Colors.grey[850],
  ),
);
