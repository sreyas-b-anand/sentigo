import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFE8B99A),

    // Main Sentigo color
    primary: const Color(0xFFFDEEE3),

    // Output section
    primaryContainer: const Color(0xFFFFF8F3),

    // Small accent color
    secondary: const Color(0xFF8FA99A),

    // Text
    onSurface: const Color(0xFF222222),
    onPrimary: const Color(0xFF222222),
    onPrimaryContainer: const Color(0xFF222222),
  ),

  scaffoldBackgroundColor: const Color(0xFFFFFAF6),

  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      color: const Color(0xFF222222),
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),

    titleLarge: GoogleFonts.poppins(
      color: const Color(0xFF222222),
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),

    titleMedium: GoogleFonts.poppins(
      color: const Color(0xFF222222),
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),

    titleSmall: GoogleFonts.poppins(
      color: const Color(0xFF222222),
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),

    bodyLarge: GoogleFonts.poppins(
      color: const Color(0xFF55504D),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),

    bodyMedium: GoogleFonts.poppins(
      color: const Color(0xFF807873),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),

    bodySmall: GoogleFonts.poppins(
      color: const Color(0xFF717171),
      fontSize: 11,
      fontWeight: FontWeight.w400,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: const Color(0xFFFDEEE3),
    foregroundColor: const Color(0xFF222222),

    titleTextStyle: GoogleFonts.poppins(
      color: const Color(0xFF222222),
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),

    iconTheme: const IconThemeData(
      color: Color(0xFF222222),
      size: 20,
    ),
  ),

  useMaterial3: true,
);