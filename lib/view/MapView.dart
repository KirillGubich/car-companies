import 'package:cars_catalog/dao/company_dao.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../model/app_properties.dart';
import '../model/company.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  TextEditingController editingController = TextEditingController();
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final companies = CompanyDao.readAll();
    updateMarkers(companies);
  }

  addMarkers(Company companies) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Companies locations'),
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
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                initialCameraPosition: CameraPosition(
                  target: LatLng(AppProperties.mapCenter.latitude,
                      AppProperties.mapCenter.longitude),
                  zoom: AppProperties.mapZoom,
                ),
                markers: _markers.values.toSet(),
              ),
            ),
          ],
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
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
      updateMarkers(dummyListData);
      return;
    } else {
      updateMarkers(CompanyDao.readAll());
    }
  }

  void updateMarkers(List<Company> companies) async {
    setState(() {
      _markers.clear();
      for (Company company in companies) {
        final marker = Marker(
            markerId: MarkerId(company.name),
            position:
                LatLng(company.location.latitude, company.location.longitude),
            infoWindow: InfoWindow(
              title: company.name,
              snippet: company.weather.temperature.toStringAsFixed(2) +
                  "℃ (" +
                  company.weather.type +
                  "), " +
                  company.location.latitude.toStringAsFixed(2) +
                  "°, " +
                  company.location.longitude.toStringAsFixed(2) +
                  "°",
            ));
        _markers[company.name] = marker;
      }
    });
  }
}
