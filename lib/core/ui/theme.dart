import 'package:flutter/material.dart';
import 'package:movie_app/core/ui/color.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class AppTheme {
  static final mainTheme = ThemeData(
      scaffoldBackgroundColor: AppColors.black,
      useMaterial3: true,
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.lightBlue,
      ),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.black,
          centerTitle: false,
          iconTheme: IconThemeData(color: AppColors.white)),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.openSans(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: AppColors.white,
        ),
        displayMedium: GoogleFonts.openSans(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: AppColors.white,
        ),
        displaySmall: GoogleFonts.openSans(
          fontSize: 48,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        headlineMedium: GoogleFonts.openSans(
          color: AppColors.white,
          fontSize: 34,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
        ),
        headlineSmall: GoogleFonts.openSans(
          fontSize: 24,
          fontWeight: FontWeight.w400,
          color: AppColors.white,
        ),
        titleLarge: GoogleFonts.openSans(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: AppColors.white,
        ),
        titleMedium: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.15,
          color: AppColors.white,
        ),
        titleSmall: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: AppColors.white,
        ),
        bodyLarge: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          color: AppColors.white,
        ),
        bodyMedium: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          color: AppColors.white,
        ),
        labelLarge: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          color: AppColors.white,
        ),
        bodySmall: GoogleFonts.openSans(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          color: AppColors.white,
        ),
        labelSmall: GoogleFonts.openSans(
          fontSize: 10,
          fontWeight: FontWeight.w400,
          letterSpacing: 1.5,
          color: AppColors.white,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.burgundy,
        focusColor: AppColors.burgundy,
        disabledColor: AppColors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ));
}
