import 'package:cars_catalog/model/company.dart';
import 'package:cars_catalog/model/weather.dart';
import 'package:flutter/material.dart';

import '../model/location.dart';

class CatalogView extends StatefulWidget {
  const CatalogView({Key? key}) : super(key: key);

  @override
  State<CatalogView> createState() => _CatalogViewState();
}

class _CatalogViewState extends State<CatalogView> {
  final _companies = <Company>[
    Company(
        "Audi",
        "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/300px-Audi-Logo_2016.svg.png",
        Weather(24, "Cloudy"),
        Location(50, 50)),
    Company(
        "BMW",
        "https://avatars.mds.yandex.net/i?id=5a429518e1b970b0377049bebeb955b4-5904855-images-thumbs&n=13",
        Weather(12, "Rain"),
        Location(40, 60)),
  ];
  final _biggerFont = const TextStyle(fontSize: 20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
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
            company.location.latitude.toStringAsFixed(1) +
            "°, " +
            company.location.longitude.toStringAsFixed(1) +
            "°",
        style: _biggerFont,
      ),
      trailing: Image.network(company.imageUrl, width: 100, height: 100),
    );
  }
}
