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
  TextEditingController editingController = TextEditingController();
  var _companies = <Company>[];

  getCompanies() async {
    CompanyDao.uploadData().then((value) {
      setState(() {
        _companies = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCompanies();
    AppProperties.updateProperties().then((data) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget scaffoldBody;
    if (AppProperties.fontSize == 0 ||
        _companies.isEmpty ||
        !weatherUploaded()) {
      AppProperties.updateProperties();
      getCompanies();
      scaffoldBody = const Center(child: Text("Loading..."));
    } else {
      scaffoldBody = _buildList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catalog'),
        backgroundColor: AppProperties.titleBarColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)))),
            ),
          ),
          Expanded(
            child: scaffoldBody,
          ),
        ],
      ),
      backgroundColor: AppProperties.viewBackgroundColor,
    );
  }

  Widget _buildList() {
    return ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: _companies.length * 2 - 1,
        itemBuilder: (context, i) {
          if (i.isOdd) {
            return const Divider(color: Colors.black, thickness: 1);
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute<void>(builder: (context) {
      return const main.NavigationBar();
    }));
  }

  void filterSearchResults(String query) {
    List<Company> dummySearchList = CompanyDao.readAll();
    if (query.isNotEmpty && query.length >= 3) {
      List<Company> dummyListData = <Company>[];
      for (var item in dummySearchList) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      }
      setState(() {
        _companies.clear();
        _companies.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _companies.clear();
        _companies.addAll(CompanyDao.readAll());
      });
    }
  }

  bool weatherUploaded() {
    for (var company in _companies) {
      if (company.weather.type.isEmpty) {
        return false;
      }
    }
    return true;
  }
}
