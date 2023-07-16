import 'package:flutter/material.dart';
import 'package:cathnow/utils/color_schemes.g.dart';

class Style {
  static TextStyle getTextStyle() {
    return const TextStyle(
      fontFamily: 'Roboto',
    );
  }

  static ThemeData getThemeData() {
    final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
      minimumSize: const Size(88, 36),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
    );

    final InputDecorationTheme lightBlueInputDecorationTheme =
        InputDecorationTheme(
      filled: true,
      labelStyle: const TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(
          width: 2,
        ),
      ),
    );

    final DropdownMenuThemeData lightBlueDropdownTheme = DropdownMenuThemeData(
      inputDecorationTheme: lightBlueInputDecorationTheme,
    );

    final AppBarTheme appBarTheme = AppBarTheme(titleTextStyle: getTextStyle());

    return ThemeData(
        //brightness: Brightness.dark,
        colorScheme: lightColorScheme,
        useMaterial3: true,
        // Define the default font family.
        fontFamily: 'Roboto',
        appBarTheme: appBarTheme,
        dropdownMenuTheme: lightBlueDropdownTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
        // Define the default `TextTheme`. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: const TextTheme(
          displayLarge: TextStyle(
              fontSize: 72.0,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold),
          titleLarge: TextStyle(
              fontSize: 24.0,
              fontFamily: 'Roboto',
              fontStyle: FontStyle.normal),
          bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Roboto'),
        ));
  }
}
