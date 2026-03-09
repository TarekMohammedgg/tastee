import 'package:flutter/material.dart';

class AppColors {
  // Solid Colors
  static const Color primary = Color(0xFFFF6E42);
  static const Color backgroundDark = Color(0xFF0F172A);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color textGrey = Color(0xFF64748B);

  // Gradient Colors
  static const Color gradientStart = Color(0xFFFF7043);
  static const Color gradientEnd = Color(0xFFE53935);

  // Reusable Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [gradientStart, gradientEnd],
  );
}
