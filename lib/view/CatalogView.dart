import 'package:cars_catalog/model/app_properties.dart';
import 'package:cars_catalog/model/company.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dao/company_dao.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  final _companies = CompanyDao.readAll();
  double _fontSize = 16;
  Color _fontColor = Colors.black;

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
    uploadFontSize().then((value) {
      setState(() {
        _fontSize = value;
      });
    });
    uploadColor().then((value) {
      setState(() {
        _fontColor = value;
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        backgroundColor: Colors.green[700],
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: _companies.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider();
          }
          final index = i ~/ 2;
          return _buildRow(_companies[index]);
        });
  }

  Widget _buildRow(Company company) {
    return ListTile(
      title: Text(
        company.name +
            " \n" +
            company.weather.temperature.toString() +
            "℃, " +
            company.weather.type +
            "\n" +
            company.location.latitude.toStringAsFixed(2) +
            "°, " +
            company.location.longitude.toStringAsFixed(2) +
            "°",
        style: TextStyle(fontSize: _fontSize, color: _fontColor),
      ),
      trailing: Image.network(company.imageUrl, width: 100, height: 100),
    );
  }
}
