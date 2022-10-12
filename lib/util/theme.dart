import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFFFFF),
    scaffoldBackgroundColor: const Color(0xFFFFFFFF),
    colorScheme: const ColorScheme.light(
      background: Color(0xFFFFFFFF),
      primary: Color(0xFFe0382f),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFFe0382f),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFFFFFFF),
        color: Color(0xFFFFFFFF),
    ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFFF2F2F2),
      color: Color(0xFFF2F2F2),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFFFFFF),     
    ),
    inputDecorationTheme: InputDecorationTheme(       
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7665C),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.3),
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFEFEFEF),
      selectedItemColor: Color(0xFFe0382f),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFed4f42),
    ),
    snackBarTheme: SnackBarThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    bottomAppBarColor: const Color(0xFFE8E8EF),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFEFEFEF),
        surfaceTintColor: const Color(0xFFEFEFEF),
        indicatorColor: const Color(0xffe53e35),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFFE8E8EF)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1B1B1D),
    scaffoldBackgroundColor: const Color(0xFF1B1B1D),
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF1B1B1D),
      primary: Color(0xFFE7665C),
      onPrimary: Color(0xFF5F150E),
      secondary: Color(0xFFE7665C),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFF1B1B1D),
        color: Color(0xFF1B1B1D),
     ),
    cardTheme: const CardTheme(
      surfaceTintColor: Color(0xFF2E2D2D),
      color: Color(0xFF2E2D2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF262626),
    ),
    inputDecorationTheme: InputDecorationTheme(
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFE7665C),
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8.0)),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(8.0))),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF262626),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFf27268),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: const Color(0xFFF0F0F0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    bottomAppBarColor: const Color(0xFF262626),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF262626),
        surfaceTintColor:  const Color(0xFF262626),
        indicatorColor: const Color(0xFF6B3632),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFEEE7E6),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEEE7E6), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
        const BottomSheetThemeData(modalBackgroundColor: Color(0xFF262626)));
