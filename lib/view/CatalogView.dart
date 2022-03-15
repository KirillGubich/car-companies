import 'package:cars_catalog/model/app_properties.dart';
import 'package:cars_catalog/model/company.dart';
import 'package:cars_catalog/model/location.dart';
import 'package:flutter/material.dart';

import '../dao/company_dao.dart';
import '../main.dart' as main;

class CatalogView extends StatefulWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  var _companies = CompanyDao.readAll();

  @override
  void initState() {
    super.initState();
    CompanyDao.uploadData();
    AppProperties.updateProperties().then((data) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffoldBody;
    if (AppProperties.fontSize == 0 || _companies == null) {
      AppProperties.updateProperties();
      CompanyDao.uploadData();
      _companies = CompanyDao.readAll();
      scaffoldBody = const Text("");
    } else {
      scaffoldBody = _buildList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        backgroundColor: AppProperties.titleBarColor,
      ),
      body: scaffoldBody,
      backgroundColor: AppProperties.viewBackgroundColor,
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: _companies.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider(color: Colors.black);
          }
          final index = i ~/ 2;
          return _buildRow(_companies[index]);
        });
  }

  Widget _buildRow(Company company) {
    double _fontSize = AppProperties.fontSize;
    Color _fontColor = AppProperties.fontColor;

    return ListTile(
      title: Text(
        company.name +
            " \n" +
            company.weather.temperature.toStringAsFixed(0) +
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
      onTap: () => switchToMapScreen(company.location),
    );
  }

  void switchToMapScreen(Location location) {
    AppProperties.mapCenter = location;
    AppProperties.mapZoom = 6;
    AppProperties.currentScreen = 1;
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      return const main.NavigationBar();
    }));
  }
}
