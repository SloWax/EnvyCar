class Weather {
  double lon = 0.0;
  double lat = 0.0;
  int weatherCode = 0;
  String description = '';
  String icon = '';
  double temperature = 0.0;

  Weather(this.lon, this.lat, this.weatherCode, this.description, this.icon,
      this.temperature);

  Weather.fromJson(Map<String, dynamic> weatherMap) {
    lon = weatherMap['coord']['lon'];
    lat = weatherMap['coord']['lat'];
    weatherCode = weatherMap['weather'][0]['id'];
    description = weatherMap['weather'][0]['main'];
    icon = weatherMap['weather'][0]['icon'];
    temperature = (weatherMap['main']['temp'] - 273.15);
  }
}
