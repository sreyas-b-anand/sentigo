import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 14, 6, 61),
    primary: const Color.fromARGB(255, 253, 238, 227),
    secondary: Colors.blueAccent,
    onSurface : Colors.black,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 241, 241, 241),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 36,
      fontWeight: FontWeight.w800,
    ),
    titleLarge: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
    titleMedium: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 24,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 20,
      fontWeight: FontWeight.w300,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 85, 81, 81),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 128, 118, 118),
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    bodySmall: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 113, 113, 113),
      fontSize: 11,
      fontWeight: FontWeight.w200,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: const Color.fromARGB(255, 253, 238, 227),
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Colors.white , size: 20),
  ),
  useMaterial3: true,
);
