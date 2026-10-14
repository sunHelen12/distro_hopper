import 'package:flutter/material.dart';

class CoresTux {
  static const Color preto = Color(0xFF1B1B1D); 
  static const Color branco = Color(0xFFFFFFFF); 
  static const Color laranja = Color(0xFFF29C1F); 
  static const Color laranjaEscuro = Color(0xFFD6780A);
  static const Color fundo = Color(0xFFF6F6F4); 
  static const Color cinza = Color(0xFF5F5F63); 
}

final ThemeData tema = ThemeData(
  useMaterial3: true,
  scaffoldBackgroundColor: CoresTux.fundo,
  colorScheme: const ColorScheme.light(
    primary: CoresTux.preto,
    onPrimary: CoresTux.branco,
    secondary: CoresTux.laranja,
    onSecondary: CoresTux.preto,
    tertiary: CoresTux.laranjaEscuro,
    surface: CoresTux.branco,
    onSurface: CoresTux.preto,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: CoresTux.preto,
    foregroundColor: CoresTux.branco,
    iconTheme: IconThemeData(color: CoresTux.laranja),
    titleTextStyle: TextStyle(
      color: CoresTux.branco,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  cardTheme: CardThemeData(
    color: CoresTux.branco,
    elevation: 1,
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
      side: const BorderSide(color: Color(0xFFE2E2DE)),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: CoresTux.laranja,
      foregroundColor: CoresTux.preto,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: CoresTux.laranja),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: CoresTux.laranja, width: 2),
    ),
  ),
  chipTheme: const ChipThemeData(
    backgroundColor: CoresTux.preto,
    labelStyle: TextStyle(color: CoresTux.branco),
    side: BorderSide.none,
  ),
);