import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Color.fromARGB(255, 14, 6, 61),
    primary: const Color.fromARGB(255, 6, 14, 46),
    secondary: Colors.blueAccent,
  ),
  scaffoldBackgroundColor: const Color.fromARGB(255, 207, 207, 207),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 0, 0, 0),
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 119, 116, 116),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.poppins(
      color: const Color.fromARGB(255, 115, 115, 115),
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
    backgroundColor: const Color.fromARGB(255, 6, 14, 46),
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.sacramento(
      color: Colors.white,
      fontSize: 28,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: const IconThemeData(color: Colors.white , size: 20),
  ),
  useMaterial3: true,
);
