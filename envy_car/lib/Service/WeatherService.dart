import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherService {
  final String domain = 'api.openweathermap.org';
  final String path = 'data/2.5/weather';
  final String apiKey = '35bc6c3ea0807b59455f3bfb5e237c97';

  Future<Weather> getWeather(String lat, String lon) async {
    Map<String, dynamic> parameters = {'lat': lat, 'lon': lon, 'appid': apiKey};
    Uri uri = Uri.http(domain, path, parameters);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);

    return weather;
  }
}
