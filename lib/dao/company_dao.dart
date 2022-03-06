import '../model/company.dart';
import '../model/location.dart';
import '../model/weather.dart';

class CompanyDao {

  static readAll() {

    return <Company>[
      Company(
          "Audi",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/9/92/Audi-Logo_2016.svg/300px-Audi-Logo_2016.svg.png",
          Weather(24, "cloudy"),
          Location(48.45, 11.25)),
      Company(
          "BMW",
          "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/1024px-BMW_logo_%28gray%29.svg.png",
          Weather(12, "rainy"),
          Location(48.08, 11.34)),
      Company(
          "Peugeot",
          "https://clipart-best.com/img/peugeot/peugeot-clip-art-40.png",
          Weather(14, "cloudy"),
          Location(48.50, 2.20)),
      Company(
          "Skoda",
          "https://www.pngmart.com/files/10/Skoda-Logo-PNG-Clipart.png",
          Weather(10, "cloudy"),
          Location(50.24, 14.54)),
    ];
  }
}