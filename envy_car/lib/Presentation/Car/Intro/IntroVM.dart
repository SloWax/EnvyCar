import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:envy_car/Service/WeatherService.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class IntroVM with ChangeNotifier {
  String _lon = "";
  String _lat = "";

  Future<void> getCurrentLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    _lat = '${position.latitude}';
    _lon = '${position.longitude}';

    getWeatherData();
  }

  void getWeatherData() async {
    WeatherService helper = WeatherService();
    Weather result;
    String carwashMessage;

    result = await helper.getWeather(_lat, _lon);

    int code = (result.weatherCode ~/ 100);

    if (result.weatherCode == 800) {
      carwashMessage = '세차하기 좋은날이에요:)';
    } else if (code == 7 || code == 8) {
      carwashMessage = '흐린날이니 세차전 예보를 확인해주세요!';
    } else if (code == 2 || code == 3 || code == 5) {
      carwashMessage = '비 소식이 있으니 세차를 피해주세요!';
    } else if (code == 6) {
      carwashMessage = '눈 소식이 있으니 세차를 피해주세요!';
    } else {
      carwashMessage = result.description;
    }

    CarManager().result = result;
    CarManager().carwashMessage = carwashMessage;

    notifyListeners();
  }
}
