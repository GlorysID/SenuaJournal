import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Primary Colors - Deep Cyber Dark & Neon Green
  static const Color primaryColor = Color(
    0xFF070707,
  ); // Slightly elevated black
  static const Color secondaryColor = Color(0xFF0F0F0F); // Layered surface
  static const Color accentColor = Color(0xFF39FF14); // Vibrant Neon Green
  static const Color textColor = Color(0xFFFFFFFF); // Pure white
  static const Color errorColor = Color(0xFFFF3B3B); // Sharp red
  static const Color successColor = Color(0xFF39FF14);
  static const Color warningColor = Color(0xFFFFB800);

  // Additional Colors for depth
  static const Color cardDark = Color(0xFF141414); // Dark charcoal
  static const Color borderColor = Color(0xFF222222); // Subtle border
  static const Color textSecondary = Color(0xFF888888); // Muted focus
  static const Color shimmerBase = Color(0xFF1A1A1A);
  static const Color shimmerHighlight = Color(0xFF252525);

  // Gradients
  static final LinearGradient primaryGradient = LinearGradient(
    colors: [const Color(0xFF000000), const Color(0xFF0A0A0A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient accentGradient = LinearGradient(
    colors: [accentColor, const Color(0xFF2BC90F)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient successGradient = accentGradient;

  static final LinearGradient cardGradient = LinearGradient(
    colors: [cardDark, const Color(0xFF0A0A0A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final LinearGradient glassyGradient = LinearGradient(
    colors: [
      Colors.white.withValues(alpha: 0.05),
      Colors.white.withValues(alpha: 0.02),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: accentColor,
    scaffoldBackgroundColor: primaryColor,
    cardColor: cardDark,
    colorScheme: const ColorScheme.dark(
      primary: accentColor,
      secondary: accentColor,
      surface: cardDark,
      error: errorColor,
      onPrimary: primaryColor,
      onSecondary: textColor,
      onSurface: textColor,
      onError: Colors.white,
    ),
    fontFamily: GoogleFonts.outfit().fontFamily,
    useMaterial3: true,
    textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme).copyWith(
      displayLarge: const TextStyle(
        color: textColor,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: const TextStyle(color: textColor),
      bodyMedium: const TextStyle(color: textSecondary),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      centerTitle: true,
      surfaceTintColor: Colors.transparent,
      iconTheme: IconThemeData(color: textColor),
      titleTextStyle: TextStyle(
        color: textColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: accentColor,
        foregroundColor: primaryColor,
        elevation: 8,
        shadowColor: accentColor.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: accentColor,
        textStyle: const TextStyle(fontWeight: FontWeight.w600),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: cardDark.withValues(alpha: 0.6),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: accentColor, width: 2.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: errorColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: errorColor, width: 2.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      labelStyle: const TextStyle(
        color: textSecondary,
        fontWeight: FontWeight.w500,
      ),
      hintStyle: const TextStyle(
        color: Colors.grey,
        fontWeight: FontWeight.w400,
      ),
      prefixIconColor: accentColor,
      suffixIconColor: accentColor,
    ),
    cardTheme: CardThemeData(
      color: cardDark,
      elevation: 12,
      shadowColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      surfaceTintColor: Colors.transparent,
    ),
    dividerTheme: const DividerThemeData(
      color: borderColor,
      thickness: 1.5,
      space: 32,
    ),
    iconTheme: const IconThemeData(color: accentColor, size: 24),
    chipTheme: ChipThemeData(
      backgroundColor: cardDark,
      selectedColor: accentColor.withValues(alpha: 0.2),
      labelStyle: const TextStyle(
        color: textColor,
        fontWeight: FontWeight.w500,
      ),
      secondaryLabelStyle: const TextStyle(
        color: accentColor,
        fontWeight: FontWeight.bold,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: const BorderSide(color: borderColor),
      ),
      brightness: Brightness.dark,
    ),
  );

  // Shadow Presets for Neon Effects
  static List<BoxShadow> getNeonShadow({Color? color, double opacity = 0.3}) {
    return [
      BoxShadow(
        color: (color ?? accentColor).withValues(alpha: opacity),
        blurRadius: 15,
        spreadRadius: -2,
        offset: const Offset(0, 4),
      ),
      BoxShadow(
        color: (color ?? accentColor).withValues(alpha: opacity * 0.5),
        blurRadius: 30,
        spreadRadius: -10,
        offset: const Offset(0, 10),
      ),
    ];
  }

  // Utility methods for common styles
  static BoxDecoration getGlassyDecoration({
    double opacity = 0.1,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      color: accentColor.withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor.withValues(alpha: 0.3), width: 1.5),
    );
  }

  static BoxDecoration getCardDecoration({double borderRadius = 20}) {
    return BoxDecoration(
      gradient: cardGradient,
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(color: borderColor.withValues(alpha: 0.2), width: 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration getGradientDecoration({
    required LinearGradient gradient,
    double borderRadius = 16,
  }) {
    return BoxDecoration(
      gradient: gradient,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }
}
