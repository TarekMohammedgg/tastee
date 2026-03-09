import 'package:flutter/material.dart';
import 'package:tastee/core/constants/app_colors.dart';

class AppTextStyles {
  // Define the family name exactly as it appears in your pubspec.yaml
  static const String fontFamily = 'PlusJakartaSans';

  // --- Bold (700) ---
  static const TextStyle bold30 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 30,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bold24 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bold20 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bold18 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 18,
    fontWeight: FontWeight.w700,
    color: AppColors.backgroundDark,
  );

  static const TextStyle bold14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  // --- Semi-Bold (600) ---
  static const TextStyle semiBold16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle semiBold14 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  // --- Regular (400) ---
  static const TextStyle regular16 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle regular12 = TextStyle(
    fontFamily: fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );
}
