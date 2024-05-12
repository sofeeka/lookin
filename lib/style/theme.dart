import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'colors.dart';

class LookInTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: CColors.lightPrimaryColor,
    colorScheme: const ColorScheme.light().copyWith(
      primary: CColors.lightPrimaryColor,
      secondary: CColors.lightSecondaryColor,
    ),
    scaffoldBackgroundColor: CColors.lightBackgroundColor,
    textTheme: const TextTheme(
      // todo add colors
      titleMedium: TextStyle(
        color: CColors.lightDividerColor,
        fontWeight: FontWeight.w800,
        fontSize: 20,
      ),
    ),
    iconTheme: const IconThemeData(color: CColors.lightIconColor),
    dividerColor: CColors.lightDividerColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: CColors.lightSelectedItemColor,
      unselectedItemColor: CColors.lightUnselectedItemColor,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: CColors.darkPrimaryColor,
    colorScheme: const ColorScheme.dark().copyWith(
      primary: CColors.darkPrimaryColor,
      secondary: CColors.darkSecondaryColor,
    ),
    scaffoldBackgroundColor: CColors.darkBackgroundColor,
    textTheme: const TextTheme(
      // todo add colors
      titleMedium: TextStyle(
        color: CColors.darkUnselectedItemColor,
        fontWeight: FontWeight.w800,
        fontSize: 20
      ),
    ),
    iconTheme: const IconThemeData(color: CColors.darkIconColor),
    dividerColor: CColors.darkDividerColor,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedItemColor: CColors.darkSelectedItemColor,
      unselectedItemColor: CColors.darkUnselectedItemColor,
    ),
  );
}
