import 'package:flutter/material.dart';

class AppTheme extends ThemeExtension<AppTheme> {
  final Color? appBarColor;
  final Color? appBarTextColor;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? buttonColor;
  final Color? buttonTextColor;

  const AppTheme({
   
    this.appBarColor,
    this.appBarTextColor,
    this.backgroundColor,
    this.textColor,
    this.buttonColor,
    this.buttonTextColor,
  });

  @override
  AppTheme copyWith({
    String? appBarTitle,
    Color? appBarColor,
    Color? appBarTextColor,
    Color? backgroundColor,
    Color? textColor,
    Color? buttonColor,
    Color? buttonTextColor,
  }) {
    return AppTheme(
      appBarColor: appBarColor ?? this.appBarColor,
      appBarTextColor: appBarTextColor ?? this.appBarTextColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textColor: textColor ?? this.textColor,
      buttonColor: buttonColor ?? this.buttonColor,
      buttonTextColor: buttonTextColor ?? this.buttonTextColor,
    );
  }

  @override
  AppTheme lerp(ThemeExtension<AppTheme>? other, double t) {
    if (other is! AppTheme) return this;
    return AppTheme(
      appBarColor: Color.lerp(appBarColor, other.appBarColor, t),
      appBarTextColor: Color.lerp(appBarTextColor, other.appBarTextColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t),
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t),
    );
  }
}

/// Classic theme instance
final classicTheme = AppTheme(
  appBarColor: const Color(0xFF3E4A59),
  appBarTextColor: Colors.white,
  backgroundColor: const Color(0xFFF4F4F4),
  textColor: const Color(0xFF2E2E2E),
  buttonColor: const Color(0xFF4A90E2),
  buttonTextColor: Colors.white,
);
