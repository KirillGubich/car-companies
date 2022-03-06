import 'package:cars_catalog/model/company.dart';
import 'package:flutter/material.dart';

import '../dao/company_dao.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {

  final _companies = CompanyDao.readAll();
  final _biggerFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
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
            " (" +
            company.weather.temperature.toString() +
            "℃, " +
            company.weather.type +
            ")\n" +
            company.location.latitude.toStringAsFixed(2) +
            "°, " +
            company.location.longitude.toStringAsFixed(2) +
            "°",
        style: _biggerFont,
      ),
      trailing: Image.network(company.imageUrl, width: 100, height: 100),
    );
  }
}
