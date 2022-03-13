import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppProperties {
  static final fontColors = <Color>[
    Colors.black,
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown
  ];

  static double fontSize = 0;
  static Color fontColor = Colors.black;
  static Color titleBarColor = Colors.black38;
  static Color navigationBarColor = Colors.red;

  static Future<void> updateProperties() async {
    final prefs = await SharedPreferences.getInstance();
    fontSize = prefs.getDouble('fontSize') ?? 20;
    final index = prefs.getInt("colorIndex") ?? 0;
    fontColor = AppProperties.fontColors[index];
  }
}
