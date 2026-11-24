import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Cores tiradas dos prints do protótipo (ajuste os hex se tiver o valor exato).
const cream = Color(0xFFF4EBDF);
const espresso = Color(0xFF2B1B14);
const terracotta = Color(0xFFB5532A);
const caramel = Color(0xFFD98C5F);
const mustard = Color(0xFFC98D3A);
const fieldBorder = Color(0xFFE4D3BD);

/// Os testes desligam as fontes da web (que exigem internet).
bool useWebFonts = true;

TextStyle displayStyle(double size) {
  if (!useWebFonts) {
    return TextStyle(fontSize: size, fontWeight: FontWeight.w700, color: espresso);
  }
  return GoogleFonts.fraunces(
    fontSize: size,
    fontWeight: FontWeight.w700,
    color: espresso,
  );
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: terracotta,
      primary: terracotta,
      surface: cream,
    ),
    scaffoldBackgroundColor: cream,
  );
  final text = useWebFonts ? GoogleFonts.dmSansTextTheme(base.textTheme) : base.textTheme;
  return base.copyWith(
    textTheme: text.apply(bodyColor: espresso, displayColor: espresso),
  );
}
