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
  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    final companies = CompanyDao.readAll();
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

  addMarkers(Company companies) {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Companies locations'),
          backgroundColor: AppProperties.titleBarColor,
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: const CameraPosition(
            target: LatLng(0, 0),
            zoom: 2,
          ),
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}
