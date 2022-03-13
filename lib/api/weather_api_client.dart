import 'dart:convert';

import 'package:cars_catalog/model/location.dart';
import 'package:cars_catalog/model/weather.dart';
import 'package:http/http.dart';

class WeatherApiClient {

  static Future<Weather> getCurrentTemperature(Location location) async {
    Response response =
        await get(Uri.parse('https://api.openweathermap.org/data/2.5/onecall?'
            'lat=${location.latitude}'
            '&lon=${location.longitude}'
            '&appid=86e308a0d21581e79c5054e17b66fbd1'));

    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> currentWeather = jsonDecode(data);
      return Weather.parse(currentWeather);
    } else {
      return Weather(0, "");
    }
  }
}
