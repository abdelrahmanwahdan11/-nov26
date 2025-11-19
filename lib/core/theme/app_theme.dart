import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light(int seed) {
    final colorScheme = ColorScheme.fromSeed(seedColor: Color(seed));
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: GoogleFonts.manrope().fontFamily,
      textTheme: GoogleFonts.manropeTextTheme(),
      scaffoldBackgroundColor: const Color(0xFFF7F8FB),
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        shadowColor: Colors.black12,
      ),
      chipTheme: ChipThemeData(
        shape: StadiumBorder(),
        selectedColor: colorScheme.primary.withOpacity(.15),
        side: BorderSide(color: colorScheme.primary.withOpacity(.2)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }

  static ThemeData dark(int seed) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: Color(seed),
      brightness: Brightness.dark,
    );
    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: GoogleFonts.manrope().fontFamily,
      textTheme: GoogleFonts.manropeTextTheme(),
      scaffoldBackgroundColor: const Color(0xFF0D0F1A),
      cardTheme: CardTheme(
        color: const Color(0xFF151829),
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28),
        ),
        shadowColor: Colors.black54,
      ),
      chipTheme: ChipThemeData(
        shape: const StadiumBorder(),
        selectedColor: colorScheme.primary.withOpacity(.2),
        side: BorderSide(color: colorScheme.primary.withOpacity(.4)),
        labelStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
