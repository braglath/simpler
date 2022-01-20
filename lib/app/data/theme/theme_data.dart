import 'package:flutter/material.dart';

import 'package:simpler/app/data/resources/colour_resources.dart';

class ThemesData {
  static final themeData = ThemeData.fallback().copyWith(
    scaffoldBackgroundColor: ColorRes.scaffoldBG,
    backgroundColor: ColorRes.scaffoldBG,
    primaryColor: ColorRes.pinkMainBtnColor,
    primaryColorLight: ColorRes.pinkMainBtnColor,
    splashColor: ColorRes.purpleSecondaryBtnColor,
    disabledColor: Colors.grey[500],
    highlightColor: ColorRes.purpleSecondaryBtnColor,
    hintColor: ColorRes.textColor,
    //

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: ColorRes.purpleSecondaryBtnColor,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: ColorRes.purpleSecondaryBtnColor,
        foregroundColor: ColorRes.purpleSecondaryBtnColor,
        splashColor: ColorRes.purpleSecondaryBtnColor,
        elevation: 4),

    appBarTheme: const AppBarTheme(
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
      backgroundColor: ColorRes.scaffoldBG,
      elevation: 0,
      iconTheme: IconThemeData(color: ColorRes.textColor),
    ),
    dividerTheme: DividerThemeData(thickness: 2, color: Colors.grey.shade700),

// ! input decoration
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      labelStyle: const TextStyle(
          color: ColorRes.textColor, fontWeight: FontWeight.bold, fontSize: 20),
      fillColor: ColorRes.pureWhite,
      errorStyle: const TextStyle().copyWith(
          color: ColorRes.redErrorColor,
          fontWeight: FontWeight.bold,
          fontSize: 17),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide:
            const BorderSide(width: 2, color: ColorRes.purpleSecondaryBtnColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 2.0,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(
          color: Colors.red,
          width: 2.0,
        ),
      ),
    ),

    textTheme: TextTheme(
      headline1: const TextStyle().copyWith(
          fontWeight: FontWeight.normal,
          fontSize: 45,
          color: ColorRes.textColor,
          fontFamily: 'Source Sans Pro'),
      headline2: const TextStyle().copyWith(
          color: ColorRes.textColor,
          fontWeight: FontWeight.normal,
          fontSize: 35,
          fontFamily: 'Source Sans Pro'),
      headline3: const TextStyle().copyWith(
          color: ColorRes.textColor,
          fontWeight: FontWeight.normal,
          fontSize: 25,
          fontFamily: 'Source Sans Pro'),
      headline4: const TextStyle().copyWith(
          color: ColorRes.textColor,
          fontWeight: FontWeight.normal,
          fontSize: 17,
          fontFamily: 'Source Sans Pro'),
      caption: const TextStyle().copyWith(
          color: Colors.grey.shade500,
          fontWeight: FontWeight.normal,
          fontSize: 15),
    ).apply(fontFamily: 'Source Sans Pro'),
  );
}
