import 'package:flutter/material.dart';
class ThemeConstants {
  // Cores principais
  static const Color primaryColor = Color(0xFF8B0000); // Vermelho escuro
  static const Color accentColor = Color(0xFF1E90FF); // Azul neon
  static const Color backgroundColor = Color(0xFF121212); // Preto/cinza muito escuro
  static const Color surfaceColor = Color(0xFF1E1E1E); // Cinza escuro
  static const Color inputBackgroundColor = Color(0xFF2A2A2A); // Fundo para inputs
  static const Color borderColor = Color(0xFF444444); // Cor de borda
  
  // Cores de texto
  static const Color textColor = Color(0xFFFFFFFF); // Branco
  static const Color textSecondaryColor = Color(0xFFAAAAAA); // Cinza claro
  
  // Cores de status
  static const Color successColor = Color(0xFF4CAF50); // Verde
  static const Color warningColor = Color(0xFFFFC107); // Amarelo
  static const Color dangerColor = Color(0xFFE53935); // Vermelhoo
  
  // Elevações
  static const double elevationLow = 1.0;
  static const double elevationMedium = 4.0;
  static const double elevationHigh = 8.0;
  
  // Durações de animação
  static const Duration animationDurationShort = Duration(milliseconds: 200);
  static const Duration animationDurationMedium = Duration(milliseconds: 500);
  static const Duration animationDurationLong = Duration(milliseconds: 800);
  
  // Gradientes
  static const LinearGradient darkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF1A1A1A),
      Color(0xFF0A0A0A),
    ],
  );
  
  // Tema completo
  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: surfaceColor,
        foregroundColor: textColor,
        elevation: elevationMedium,
      ),
      cardTheme: const CardTheme(
        color: surfaceColor,
        elevation: elevationMedium,
        margin: EdgeInsets.symmetric(vertical: 8.0),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: textColor,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentColor,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: accentColor,
          side: BorderSide(color: accentColor),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: surfaceColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: textSecondaryColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: textSecondaryColor.withOpacity(0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: accentColor),
        ),
        labelStyle: TextStyle(color: textSecondaryColor),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: textColor),
        bodyMedium: TextStyle(color: textColor),
        titleLarge: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.bold),
        titleSmall: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
      colorScheme: ColorScheme.dark(
        primary: primaryColor,
        secondary: accentColor,
        surface: surfaceColor,
        background: backgroundColor,
        error: dangerColor,
      ),
    );
  }
}
