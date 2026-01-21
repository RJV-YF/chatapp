import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = CupertinoColors.activeGreen;
  static const Color secondaryBlue = CupertinoColors.activeBlue;
  static const Color neutralGrey = Color(0xFF6B7280);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: false,

    scaffoldBackgroundColor: Colors.white,

    primaryColor: primaryGreen,

    colorScheme: ColorScheme.light(
      primary: primaryGreen,
      secondary: secondaryBlue,
      surface: Colors.white,
      onSurface: Colors.black,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: true,
    ),

    textTheme: const TextTheme(bodyMedium: TextStyle(color: neutralGrey)),

    iconTheme: const IconThemeData(color: neutralGrey),

    dividerColor: Color(0xFFE5E7EB),
  );
}
