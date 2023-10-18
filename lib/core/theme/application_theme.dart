import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplicationTheme {
  static Color primaryColor = const Color(0xff5D9CEC);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor,
      onPrimary: Colors.white,
      seedColor: primaryColor,
      onSecondary: const Color(0xff61E757),
      background: const Color(0xffDFECDB),
    ),
    scaffoldBackgroundColor: const Color(0xffDFECDB),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      toolbarHeight: 140,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
      elevation: 0,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      selectedItemColor: primaryColor,
      unselectedIconTheme: const IconThemeData(
        color: Color(0xffC8C9CB),
        size: 32,
      ),
      unselectedItemColor: const Color(0xffC8C9CB),
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: Colors.white,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: const Color(0xff363636),
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: const Color(0xff363636),
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.fromSeed(
      primary: primaryColor,
      onPrimary: const Color(0xff060E1E),
      seedColor: primaryColor,
      onSecondary: const Color(0xff61E757),
    ),
    scaffoldBackgroundColor: const Color(0xff060E1E),
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(
        color: Color(0xff060E1E),
      ),
      elevation: 0,
      backgroundColor: primaryColor,
      centerTitle: false,
      toolbarHeight: 140,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xff141922),
      selectedIconTheme: IconThemeData(
        color: primaryColor,
        size: 35,
      ),
      selectedItemColor: primaryColor,
      unselectedIconTheme: const IconThemeData(
        color: Color(0xffC8C9CB),
        size: 32,
      ),
      unselectedItemColor: const Color(0xffC8C9CB),
    ),
    textTheme: TextTheme(
        titleLarge: GoogleFonts.poppins(
          fontWeight: FontWeight.bold,
          fontSize: 22,
          color: const Color(0xff060E1E),
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
        bodyMedium: GoogleFonts.roboto(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        bodySmall: GoogleFonts.roboto(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          color: Colors.white,
        )),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
    ),
  );
}