import 'package:geolocator/geolocator.dart';
import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:envy_car/Service/WeatherService.dart';
import 'package:flutter/material.dart';

class CarVM with ChangeNotifier {
  String lon = "";
  String lat = "";
  String carwashMessage = "";
  Weather result = Weather(0.0, 0.0, 0, '', '', 0.0);
  bool isWeatherLoad = false;

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      isWeatherLoad = true;

      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    lat = '${position.latitude}';
    lon = '${position.longitude}';

    getWeatherData();
  }

  void getWeatherData() async {
    WeatherService helper = WeatherService();
    result = await helper.getWeather(lat, lon);

    int code = (result.weatherCode ~/ 100);

    if (result.weatherCode == 800) {
      carwashMessage = '세차하기 좋은날이에요:)';
    } else if (code == 7 || code == 8) {
      carwashMessage = '흐린날씨이니 세차전 일기예보를 확인해주세요!';
    } else if (code == 2 || code == 3 || code == 5) {
      carwashMessage = '비 소식이 있으니 세차를 피해주세요!';
    } else if (code == 6) {
      carwashMessage = '눈 소식이 있으니 세차를 피해주세요!';
    } else {
      carwashMessage = result.description;
    }

    isWeatherLoad = true;

    notifyListeners();
  }
}
