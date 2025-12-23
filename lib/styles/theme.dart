// lib/styles/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Shadcn UI 기본 색상 팔레트 (Zinc 테마 기준 예시)
  static const Color background = Colors.white;
  static const Color foreground = Color(0xFF09090b);
  
  static const Color primary = Color(0xFF18181b);
  static const Color primaryForeground = Color(0xFFfafafa);
  
  static const Color muted = Color(0xFFf4f4f5);
  static const Color mutedForeground = Color(0xFF71717a);
  
  static const Color border = Color(0xFFe4e4e7);
  static const Color destructive = Color(0xFFef4444);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: GoogleFonts.inter().fontFamily,
      
      // 색상 스키마 정의
      colorScheme: const ColorScheme.light(
        onBackground: foreground,
        surface: background,
        onSurface: foreground,
        primary: primary,
        onPrimary: primaryForeground,
        secondary: muted,
        onSecondary: mutedForeground,
        error: destructive,
        onError: Colors.white,
        outline: border,
      ),

      // Scaffold 배경색
      scaffoldBackgroundColor: background,

      // 텍스트 테마
      textTheme: GoogleFonts.interTextTheme().apply(
        bodyColor: foreground,
        displayColor: foreground,
      ),

      // 버튼 스타일 (Tailwind 'default' variant 대응)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: primaryForeground,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6), // radius-md
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
      ),
    );
  }

  static Color? get input => null;
}