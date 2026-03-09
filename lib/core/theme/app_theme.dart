import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      // ── Color Scheme ──
      // colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),

      // ── AppBar ──
      // appBarTheme: const AppBarTheme(...),

      // ── Text ──
      // textTheme: TextTheme(...),

      // ── Input Decoration ──
      // inputDecorationTheme: InputDecorationTheme(...),

      // ── Elevated Button ──
      // elevatedButtonTheme: ElevatedButtonThemeData(...),

      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
    );
  }
}
