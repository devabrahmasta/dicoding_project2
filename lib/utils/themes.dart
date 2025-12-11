import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const Color primary = Color(0xFF0138F6); 
  static const Color secondary = Color(0xFFFEA922); 
  static const Color background = Colors.white;
  static const Color surface = Color(0xFFEAEFFF); 
  static const Color textDark = Color(0xFF212121);
  static const Color textLight = Colors.grey;
}

ThemeData lightTheme = ThemeData(
  useMaterial3: true, 
  scaffoldBackgroundColor: Colors.white,
  
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary, 
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    surface: AppColors.surface,
    brightness: Brightness.light, 
  ),

  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    
    titleLarge: GoogleFonts.poppins(
      fontSize: 22, 
      fontWeight: FontWeight.bold, 
      color: AppColors.textDark
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: 18, 
      fontWeight: FontWeight.w600, 
      color: AppColors.textDark
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: 16, 
      fontWeight: FontWeight.w500, 
      color: AppColors.textDark
    ),

    bodyLarge: GoogleFonts.poppins(
      fontSize: 16, 
      fontWeight: FontWeight.normal, 
      color: AppColors.textDark
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14, 
      fontWeight: FontWeight.normal, 
      color: AppColors.textDark
    ),
    bodySmall: GoogleFonts.poppins(
      fontSize: 12, 
      fontWeight: FontWeight.normal, 
      color: AppColors.textDark
    ),

    labelLarge: GoogleFonts.poppins(
      fontSize: 14, 
      fontWeight: FontWeight.bold,
      color: AppColors.textDark
    ), 
  ),

  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white, 
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFF5F5F5),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: AppColors.primary, width: 2), 
    ),
  ),
);