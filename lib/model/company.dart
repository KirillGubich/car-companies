import 'package:cars_catalog/model/location.dart';
import 'package:cars_catalog/model/weather.dart';

class Company {

  String name;
  String imageUrl;
  Weather weather;
  Location location;

  Company(this.name, this.imageUrl, this.weather, this.location);
}