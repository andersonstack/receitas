import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyStyles {
  static ThemeData aplyTheme() {
    return ThemeData(
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xFF4B7CCC),
        onPrimary: Color.fromARGB(255, 0, 49, 128),
        secondary: Color(0xFF77F2FF),
        onSecondary: Color.fromARGB(94, 119, 241, 255),
        surface: Color(0xFF858D99),
        onSurface: Color.fromARGB(255, 221, 221, 221),
        background: Color(0xFF4B7CCC),
        error: Colors.red,
        onError: Colors.white,
        onBackground: Color(0xFFFF8658),
      ),
      scaffoldBackgroundColor: Colors.black,
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        displayMedium: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 20.0,
        ),
        bodyLarge: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        bodyMedium: TextStyle(
          fontFamily: GoogleFonts.poppins().fontFamily,
          fontWeight: FontWeight.normal,
          fontSize: 15.0,
        ),
      ),
    );
  }
}
