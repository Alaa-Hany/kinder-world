import 'package:flutter/material.dart';
import 'package:kinder_world/core/constants/app_constants.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme({bool isChildFriendly = true}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        surface: AppColors.surface,
        error: AppColors.error,
        onPrimary: AppColors.white,
        onSecondary: AppColors.white,
        onSurface: AppColors.textPrimary,
        onError: AppColors.white,
      ),
      
      // App Bar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: isChildFriendly ? AppConstants.largeFontSize : 20,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
        iconTheme: const IconThemeData(color: AppColors.white),
      ),
      
      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      
      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          minimumSize: const Size(AppConstants.minTouchTarget, AppConstants.minTouchTarget),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: TextStyle(
            fontSize: isChildFriendly ? AppConstants.fontSize : 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      
      // Text
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: isChildFriendly ? 32 : 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        displayMedium: TextStyle(
          fontSize: isChildFriendly ? 28 : 24,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: isChildFriendly ? 24 : 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: isChildFriendly ? AppConstants.fontSize : 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: isChildFriendly ? 16 : 14,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: isChildFriendly ? AppConstants.fontSize : 16,
          fontWeight: FontWeight.w600,
          color: AppColors.white,
        ),
      ),
      
      // Cards
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: AppColors.surface,
      ),
      
      // Input Decoration
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
      
      // Visual Density
      visualDensity: isChildFriendly ? VisualDensity.comfortable : VisualDensity.standard,
    );
  }
  
  static ThemeData darkTheme({bool isChildFriendly = true}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.nightModeBackground,
      
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryLight,
        secondary: AppColors.secondaryLight,
        surface: AppColors.nightModeSurface,
        error: AppColors.error,
        onPrimary: AppColors.nightModeText,
        onSecondary: AppColors.nightModeText,
        onSurface: AppColors.nightModeText,
        onError: AppColors.nightModeText,
      ),
      
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.nightModeSurface,
        foregroundColor: AppColors.nightModeText,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: isChildFriendly ? AppConstants.largeFontSize : 20,
          fontWeight: FontWeight.bold,
          color: AppColors.nightModeText,
        ),
      ),
      
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: isChildFriendly ? 32 : 28,
          fontWeight: FontWeight.bold,
          color: AppColors.nightModeText,
        ),
        bodyLarge: TextStyle(
          fontSize: isChildFriendly ? AppConstants.fontSize : 16,
          color: AppColors.nightModeText,
        ),
      ),
    );
  }
  
  static ThemeData eyeFriendlyTheme({bool isChildFriendly = true}) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: AppColors.eyeFriendlyText,
      scaffoldBackgroundColor: AppColors.eyeFriendlyBackground,
      
      colorScheme: const ColorScheme.light(
        primary: AppColors.eyeFriendlyText,
        secondary: AppColors.secondary,
        surface: AppColors.eyeFriendlyBackground,
        error: AppColors.error,
        onPrimary: AppColors.eyeFriendlyBackground,
        onSecondary: AppColors.eyeFriendlyBackground,
        onSurface: AppColors.eyeFriendlyText,
      ),
      
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: isChildFriendly ? 36 : 32,
          fontWeight: FontWeight.bold,
          color: AppColors.eyeFriendlyText,
        ),
        bodyLarge: TextStyle(
          fontSize: isChildFriendly ? 20 : 18,
          color: AppColors.eyeFriendlyText,
        ),
      ),
    );
  }
}