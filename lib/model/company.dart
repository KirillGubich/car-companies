import 'package:cars_catalog/model/location.dart';
import 'package:cars_catalog/model/weather.dart';

class Company {
  String name;
  String imageUrl;
  Weather weather;
  Location location;

  Company(this.name, this.imageUrl, this.weather, this.location);

  factory Company.parse(dynamic companyData) {
    String name = companyData['name'];
    String imageUrl = companyData['imageUrl'];
    double latitude = companyData['location']['latitude'];
    double longitude = companyData['location']['longitude'];
    return Company(
        name, imageUrl, Weather(0, ""), Location(latitude, longitude));
  }
}
