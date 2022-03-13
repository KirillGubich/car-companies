import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/app_properties.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  double _fontSize = 20;
  Color _fontColor = Colors.black;

  changeColor(Color color) async {
    setState(() => _fontColor = color);
    AppProperties.fontColor = color;
    int index = AppProperties.fontColors.indexOf(color);
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("colorIndex", index);
  }

  changeFontSize(double fontSize) async {
    setState(() => _fontSize = fontSize);
    AppProperties.fontSize = fontSize;
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble("fontSize", fontSize);
  }

  Future<double> uploadFontSize() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble('fontSize') ?? 16;
  }

  Future<Color> uploadColor() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt("colorIndex") ?? 0;
    return AppProperties.fontColors[index];
  }

  @override
  Widget build(BuildContext context) {

    _fontSize = AppProperties.fontSize;
    _fontColor = AppProperties.fontColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: AppProperties.titleBarColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text("Font size",
                style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: _fontColor)),
            SizedBox(
              height: 80,
              child: Slider(
                value: _fontSize,
                min: 12,
                max: 30,
                divisions: 9,
                label: _fontSize.round().toString(),
                activeColor: Colors.black,
                inactiveColor: Colors.black12,
                onChanged: changeFontSize,
              ),
            ),
            const Divider(),
            Text("Font color\n",
                style: TextStyle(
                    fontSize: _fontSize,
                    fontWeight: FontWeight.bold,
                    color: _fontColor)),
            BlockPicker(
                availableColors: AppProperties.fontColors,
                pickerColor: Colors.white,
                onColorChanged: changeColor),
          ],
        ),
      ),
    );
  }
}
