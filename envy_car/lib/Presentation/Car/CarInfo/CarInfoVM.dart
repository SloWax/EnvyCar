import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:geolocator/geolocator.dart';
import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:envy_car/Service/WeatherService.dart';
import 'package:flutter/material.dart';

class CarInfoVM with ChangeNotifier {
  // String _lon = "";
  // String _lat = "";
  // String _carwashMessage = "";
  // Weather _result = Weather(0.0, 0.0, 0, '', '', 0.0);
  // bool _isWeatherLoad = false;

  // String get carwashMessage => _carwashMessage;
  // Weather get result => _result;
  // bool get isWeatherLoad => _isWeatherLoad;

  // Future<void> getCurrentLocation() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //   }

  //   if (permission == LocationPermission.denied) {
  //     _isWeatherLoad = true;

  //     return;
  //   }

  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);

  //   _lat = '${position.latitude}';
  //   _lon = '${position.longitude}';

  //   getWeatherData();
  // }

  // void getWeatherData() async {
  //   WeatherService helper = WeatherService();
  //   _result = await helper.getWeather(_lat, _lon);

  //   int code = (_result.weatherCode ~/ 100);

  //   if (_result.weatherCode == 800) {
  //     _carwashMessage = '세차하기 좋은날이에요:)';
  //   } else if (code == 7 || code == 8) {
  //     _carwashMessage = '흐린날이니 세차전 예보를 확인해주세요!';
  //   } else if (code == 2 || code == 3 || code == 5) {
  //     _carwashMessage = '비 소식이 있으니 세차를 피해주세요!';
  //   } else if (code == 6) {
  //     _carwashMessage = '눈 소식이 있으니 세차를 피해주세요!';
  //   } else {
  //     _carwashMessage = _result.description;
  //   }

  //   _isWeatherLoad = true;

  //   notifyListeners();
  // }

  void changeCar(Car value, int index) {
    CarManager().changeCar(value, index);

    notifyListeners();
  }

  void deleteCar() {
    CarManager().deleteCar();

    notifyListeners();
  }

  void setMilege(int value) {
    var car = CarManager().car;
    car.mileage = value;

    CarManager().updateCar(car);

    notifyListeners();
  }

  void setDate(DateTime value) {
    var car = CarManager().car;

    car.manageDate = value;
    CarManager().updateCar(car);

    notifyListeners();
  }
}
