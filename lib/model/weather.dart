class Weather {

  static const double kelvinDegree = 273.15;
  double temperature;
  String type;

  factory Weather.parse(Map<String, dynamic> currentWeather) {

    double currentTemperature =
        currentWeather['current']['temp'] - kelvinDegree;
    String currentCondition =
    currentWeather['current']['weather'][0]['main'].toString();

    return Weather(currentTemperature, currentCondition);
  }

  Weather(this.temperature, this.type);
}