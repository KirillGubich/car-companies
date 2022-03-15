import 'package:cars_catalog/model/location.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../view/CatalogView.dart';
import '../view/MapView.dart';
import '../view/SettingsView.dart';

class AppProperties extends ChangeNotifier {
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

  static final AppProperties _singleton = AppProperties._internal();
  static double fontSize = 0;
  static Color fontColor = Colors.black;
  static Color titleBarColor = Colors.black38;
  static Color navigationBarColor = Colors.red;
  static Color viewBackgroundColor = const Color.fromRGBO(243, 243, 243, 1);
  static int currentScreen = 0;
  static final screens = [
    const CatalogView(),
    const MapView(),
    const SettingsView()
  ];
  static Location mapCenter = Location(0, 0);
  static double mapZoom = 1;

  static Future<void> updateProperties() async {
    final prefs = await SharedPreferences.getInstance();
    fontSize = prefs.getDouble('fontSize') ?? 20;
    final index = prefs.getInt("colorIndex") ?? 0;
    fontColor = AppProperties.fontColors[index];
  }

  AppProperties._internal();

  changeScreen(int screenIndex) async {
    currentScreen = screenIndex;
    notifyListeners();
  }

  factory AppProperties() {
    return _singleton;
  }
}
