import 'package:cars_catalog/model/app_properties.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Car catalog",
      home: NavigationBar(),
    );
  }
}

class NavigationBar extends StatefulWidget {
  const NavigationBar({Key? key}) : super(key: key);

  @override
  State<NavigationBar> createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppProperties.screens[AppProperties.currentScreen],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        currentIndex: AppProperties.currentScreen,
        onTap: (index) => setState(() => AppProperties.currentScreen = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.list),
            label: "Catalog",
            backgroundColor: AppProperties.navigationBarColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            label: "Map",
            backgroundColor: AppProperties.navigationBarColor,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: "Settings",
            backgroundColor: AppProperties.navigationBarColor,
          ),
        ],
      ),
    );
  }
}
