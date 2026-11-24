import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFFF3ECE1); // Creme de fundo
  static const Color surface = Color(0xFFFFFFFF); // Branco dos cards
  static const Color primaryDark = Color(0xFF291B12); // Café escuro (botões/chips)
  static const Color terracotta = Color(0xFFA34E24); // Terracota (banner, preços, CTAs)
  static const Color terracottaLight = Color(0xFFC87D55); // Círculo translúcido do banner
  static const Color ochre = Color(0xFFC78A38); // Cor do card Pão de queijo
  static const Color textDark = Color(0xFF291B12);
  static const Color textMuted = Color(0xFF6B5D54);
  static const Color borderLight = Color(0xFFE2D8CB);

  static ThemeData get lightTheme {
    final baseTextTheme = GoogleFonts.dmSansTextTheme();

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: terracotta,
        primary: primaryDark,
        secondary: terracotta,
        surface: surface,
      ),
      textTheme: baseTextTheme.copyWith(
        headlineLarge: GoogleFonts.fraunces(
          fontSize: 28,
          fontWeight: FontWeight.w800,
          color: textDark,
          height: 1.15,
        ),
        headlineMedium: GoogleFonts.fraunces(
          fontSize: 24,
          fontWeight: FontWeight.w800,
          color: textDark,
        ),
        titleLarge: GoogleFonts.fraunces(
          fontSize: 18,
          fontWeight: FontWeight.w800,
          color: textDark,
        ),
        titleMedium: GoogleFonts.dmSans(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: textDark,
        ),
        bodyLarge: GoogleFonts.dmSans(
          fontSize: 14,
          color: textDark,
          height: 1.4,
        ),
        bodyMedium: GoogleFonts.dmSans(
          fontSize: 13,
          color: textMuted,
        ),
      ),
    );
  }

  static String formatPrice(double value) {
    return 'R\$ ${value.toStringAsFixed(2).replaceAll('.', ',')}';
  }
}
