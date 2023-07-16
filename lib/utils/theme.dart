import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'color.dart';

final lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'halter',
    // primaryColor: mainColor,
    // primarySwatch: generateMaterialColor2(mainColor),
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: Colors.white10,
    //   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
    //   hintStyle:
    //   GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.black54)),
    //   labelStyle:
    //   GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.black54)),
    //   border: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.black12),
    //       borderRadius: BorderRadius.circular(10)),
    //   enabledBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.black12),
    //       borderRadius: BorderRadius.circular(10)),
    //   focusedBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.black12),
    //       borderRadius: BorderRadius.circular(10)),
    //   errorBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.red, width: 1),
    //       borderRadius: BorderRadius.circular(10)),
    //   disabledBorder: OutlineInputBorder(
    //       borderSide: const BorderSide(color: Colors.black12),
    //       borderRadius: BorderRadius.circular(10)),
    // ),
    //
    // switchTheme: SwitchThemeData(
    //   thumbColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return appLogoColor;
    //     } else if (states.contains(MaterialState.disabled)) {
    //       return Colors.white10;
    //     }
    //     return null;
    //   }),
    //   trackColor: MaterialStateProperty.resolveWith((states) {
    //     if (states.contains(MaterialState.selected)) {
    //       return appLogoColor.withOpacity(0.5);
    //     } else {
    //       return Colors.white70;
    //     }
    //   }),
    // ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)
        .copyWith(brightness: Brightness.light));
final darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.black)
      .copyWith(brightness: Brightness.dark),
  fontFamily: 'halter',

  // primaryColor: mainColor,
  // primarySwatch: generateMaterialColor2(mainColor),
  // inputDecorationTheme: InputDecorationTheme(
  //   filled: true,
  //   fillColor: Colors.white10,
  //   contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  //   hintStyle:
  //       GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.white54)),
  //   labelStyle:
  //       GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.white54)),
  //   border: OutlineInputBorder(
  //       borderSide: const BorderSide(color: Colors.white12),
  //       borderRadius: BorderRadius.circular(10)),
  //   enabledBorder: OutlineInputBorder(
  //       borderSide: const BorderSide(color: Colors.white12),
  //       borderRadius: BorderRadius.circular(10)),
  //   focusedBorder: OutlineInputBorder(
  //       borderSide: const BorderSide(color: Colors.white12),
  //       borderRadius: BorderRadius.circular(10)),
  //   errorBorder: OutlineInputBorder(
  //       borderSide: const BorderSide(color: Colors.red, width: 1),
  //       borderRadius: BorderRadius.circular(10)),
  //   disabledBorder: OutlineInputBorder(
  //       borderSide: const BorderSide(color: Colors.white30),
  //       borderRadius: BorderRadius.circular(10)),
  // ),
  // elevatedButtonTheme: ElevatedButtonThemeData(
  //     style: ElevatedButton.styleFrom(
  //         backgroundColor: appLogoColor,
  //         shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
  // switchTheme: SwitchThemeData(
  //   thumbColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return appLogoColor;
  //     } else if (states.contains(MaterialState.disabled)) {
  //       return Colors.white10;
  //     }
  //     return null;
  //   }),
  //   trackColor: MaterialStateProperty.resolveWith((states) {
  //     if (states.contains(MaterialState.selected)) {
  //       return appLogoColor.withOpacity(0.5);
  //     } else {
  //       return Colors.white70;
  //     }
  //   }),
  // ),
);
MaterialColor generateMaterialColor(Color color) {
  return MaterialColor(color.value, {
    50: tintColor(color, 0.9),
    100: tintColor(color, 0.8),
    200: tintColor(color, 0.6),
    300: tintColor(color, 0.4),
    400: tintColor(color, 0.2),
    500: color,
    600: shadeColor(color, 0.1),
    700: shadeColor(color, 0.2),
    800: shadeColor(color, 0.3),
    900: shadeColor(color, 0.4),
  });
}

MaterialColor generateMaterialColor2(Color color) =>
    MaterialColor(color.value, {
      50: color.withOpacity(0.05),
      100: color.withOpacity(0.1),
      200: color.withOpacity(0.2),
      300: color.withOpacity(0.3),
      400: color.withOpacity(0.4),
      500: color.withOpacity(0.5),
      600: color.withOpacity(0.6),
      700: color.withOpacity(0.7),
      800: color.withOpacity(0.8),
      900: color.withOpacity(0.9),
    });

int tintValue(int value, double factor) =>
    max(0, min((value + ((255 - value) * factor)).round(), 255));

Color tintColor(Color color, double factor) => Color.fromRGBO(
    tintValue(color.red, factor),
    tintValue(color.green, factor),
    tintValue(color.blue, factor),
    1);

int shadeValue(int value, double factor) =>
    max(0, min(value - (value * factor).round(), 255));

Color shadeColor(Color color, double factor) => Color.fromRGBO(
    shadeValue(color.red, factor),
    shadeValue(color.green, factor),
    shadeValue(color.blue, factor),
    1);
