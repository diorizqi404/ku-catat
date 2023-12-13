import 'package:flutter/material.dart';

class AppStyle {
  static Color bgColor = const Color(0xFFe2e2ff);
  static Color mainColor = const Color(0xFFEFF1F3);
  static Color accentColor = const Color(0xFF0065FF);

  static List<Color> cardsColor = [
    Colors.red,
    Colors.purple.shade300,
    Colors.yellow.shade700,
    Colors.green,
    Colors.blue,
    Colors.grey.shade700,
    Colors.cyan,
  ];

  static TextStyle mainTitle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'inter');

  static TextStyle mainContent = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: Colors.white,
      fontFamily: 'inter');

  static TextStyle dateTitle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      color: Colors.white,
      fontFamily: 'inter');
}
