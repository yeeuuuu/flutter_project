import 'package:flutter/material.dart';

class AppTheme {
  // globals.css의 CSS 변수 변환
  static const Color background = Colors.white;
  static const Color foreground = Color(0xFF09090B); // --foreground
  static const Color primary = Color(0xFF18181B); // --primary
  static const Color primaryForeground = Color(0xFFFAFAFA);
  static const Color muted = Color(0xFFF4F4F5); // --muted
  static const Color mutedForeground = Color(0xFF71717A);
  static const Color border = Color(0xFFE4E4E7); // --border
  static const Color destructive = Color(0xFFEF4444); // --destructive

  static const double radius = 8.0; // --radius: 0.5rem

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      primaryColor: primary,
      colorScheme: const ColorScheme.light(
        primary: primary,
        onPrimary: primaryForeground,
        surface: background,
        onSurface: foreground,
        error: destructive,
        outline: border,
      ),
      fontFamily: 'Inter', // 폰트가 있다면 설정
      // Card 스타일 기본 적용
      cardTheme: CardTheme(
        color: background,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: const BorderSide(color: border),
        ),
        elevation: 0,
      ),
    );
  }
}
