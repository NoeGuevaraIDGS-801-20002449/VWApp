import 'package:flutter/material.dart';

class AppTheme {
  static const prim = Color.fromRGBO(31, 44, 76, 1);
  static const sec = Color.fromRGBO(58, 82, 118, 1);
  static const secd = Color.fromRGBO(101, 133, 182, 1);
  static const tre = Color.fromRGBO(171, 170, 170, 1);
  static const cua = Color.fromRGBO(92, 92, 90, 1);

  static ThemeData tema = ThemeData.light().copyWith(
      primaryColor: const Color.fromRGBO(31, 44, 76, 1),
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(color: prim, elevation: 0));

  static ThemeData tema2 = ThemeData.dark().copyWith(
      primaryColor: const Color.fromRGBO(31, 44, 76, 1),
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(color: prim, elevation: 0));
}
