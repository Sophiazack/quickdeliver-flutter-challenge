import 'package:flutter/material.dart';
import 'package:quick_deliver/theme/text_style.dart';
class AppTheme {
  static const primary = Color(0xFF20BEB8);
  static const iconColor = Color(0xFF94A3B8);
  static const black = Color(0xFF0F172A);
  static const textcolor = Color(0xFF64748B);

  static ThemeData themeData() {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      iconTheme: const IconThemeData(color: iconColor),
      scaffoldBackgroundColor: Color(0xFFF8FAFC),
      splashColor: Colors.transparent,
      cardColor: Colors.white,
      textTheme: TextTheme(
          titleLarge: titleLarge(),
          titleMedium: titleMedium(),
          titleSmall: titleSmall(),
          bodyLarge: bodyLarge(),
          bodyMedium: bodyMedium(),
          bodySmall: bodySmall()),
    );
  }
}
