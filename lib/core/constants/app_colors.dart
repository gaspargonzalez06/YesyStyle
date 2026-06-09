import 'package:flutter/material.dart';

class AppColors {
  // ─── PALETA MINIMALISTA DORADA ───────────────────────────────────────────
  // Negros
  static const Color black        = Color(0xFF0A0A0A);
  static const Color blackSoft    = Color(0xFF141414);
  static const Color blackCard    = Color(0xFF1A1A1A);
  static const Color blackBorder  = Color(0xFF2A2A2A);

  // Blancos
  static const Color white        = Color(0xFFFAFAFA);
  static const Color whiteSmoke   = Color(0xFFF0EDE8);
  static const Color whiteSoft    = Color(0xFFE5E0D8);
  static const Color whiteGhost   = Color(0xFF9A9A9A);

  // Dorados
  static const Color gold         = Color(0xFFC9A84C);
  static const Color goldLight    = Color(0xFFE8D5A3);
  static const Color goldDark     = Color(0xFF8B6A20);
  static const Color goldShimmer  = Color(0xFFD4B86A);
  static const Color goldBorder   = Color(0xFF9A7A2A);

  // ─── ALIASES ─────────────────────────────────────────────────────────────
  // Compatibilidad legacy → nuevos colores
  static const Color roseGold     = gold;
  static const Color champagne    = goldLight;
  static const Color blushPink    = goldShimmer;
  static const Color dustyRose    = goldBorder;
  static const Color warmBeige    = whiteSmoke;
  static const Color softLavender = whiteSoft;
  static const Color pearlWhite   = white;
  static const Color deepPlum     = blackSoft;
  static const Color goldenAccent = gold;

  // ─── SEMÁNTICOS ──────────────────────────────────────────────────────────
  static const Color primary      = gold;
  static const Color primaryDark  = goldDark;
  static const Color primaryLight = goldLight;
  static const Color accent       = goldShimmer;

  static const Color background   = black;
  static const Color surface      = blackCard;
  static const Color surfaceLight = blackBorder;
  static const Color textPrimary  = white;
  static const Color textSecondary= whiteGhost;
  static const Color textLight    = Color(0xFF6A6A6A);
  static const Color shadow       = Color(0x40000000);

  // ─── GRADIENTES DORADOS ───────────────────────────────────────────────────
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gold, goldDark],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient champagneGradient = LinearGradient(
    colors: [goldLight, whiteSmoke],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
  static const LinearGradient elegantGradient = LinearGradient(
    colors: [black, blackSoft, blackCard],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient goldGradient = LinearGradient(
    colors: [goldDark, gold, goldShimmer],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
  static const LinearGradient darkGradient = LinearGradient(
    colors: [black, blackSoft, blackCard],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  static const LinearGradient heroGradient = LinearGradient(
    colors: [black, Color(0xFF1A1500)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // ─── COLORES LEGACY (categorías) ─────────────────────────────────────────
  static const Color teaPartyColor     = goldShimmer;
  static const Color weddingColor      = goldLight;
  static const Color musicColor        = whiteSoft;
  static const Color decorationColor   = gold;
  static const Color organizationColor = goldDark;

  // ─── ESTADOS ─────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error   = Color(0xFFF44336);
  static const Color info    = Color(0xFF2196F3);

  // Compatibilidad legacy de sombras
  static const Color shadowMedium = Color(0x66000000);
  static const Color shadowDark = Color(0x88000000);
}
