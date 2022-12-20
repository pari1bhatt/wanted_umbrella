import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class MyTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: GetColors.purple,
      scaffoldBackgroundColor: GetColors.white,
      colorScheme: ThemeData().colorScheme.copyWith(primary: GetColors.purple, brightness: Brightness.light),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: GetColors.purple,
      scaffoldBackgroundColor: GetColors.white,
      colorScheme: ThemeData().colorScheme.copyWith(primary: GetColors.purple, brightness: Brightness.dark),
    );
  }
}
