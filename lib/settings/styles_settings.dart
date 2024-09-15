import 'package:flutter/material.dart';

ThemeData temaDia() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 54, 244, 63));
}

ThemeData temaNoche() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 0, 10, 0));
}

ThemeData temaCalido() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(backgroundColor: Color.fromARGB(255, 231, 146, 26));
}