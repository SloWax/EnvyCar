import 'dart:convert';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarManager {
  // 정적 변수로 싱글톤 인스턴스를 저장
  static final CarManager _instance = CarManager._internal();

  User _user = User('test', []);
  User get user => _user;
  Car get car => _user.carList.first;

  Weather result = Weather(0.0, 0.0, 0, '', '', 0.0);
  String carwashMessage = "";

  // 팩토리 생성자는 기존 인스턴스를 반환
  factory CarManager() {
    return _instance;
  }

  // private 생성자로 내부에서만 호출 가능
  CarManager._internal();

  Future<String?> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user");

    if (userJson != null) {
      final decode = jsonDecode(userJson);
      _user = User.fromJson(decode);
    }

    return userJson;
  }

  void addCar(Car value) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user");

    if (userJson != null) {
      final decode = jsonDecode(userJson);
      _user = User.fromJson(decode);
    }

    _user.carList.insert(0, value);

    _updateUser();
  }

  void updateCar(Car value) {
    _user.carList[0] = value;

    _updateUser();
  }

  void changeCar(Car value, int index) {
    _user.carList.removeAt(index);
    _user.carList.insert(0, value);

    _updateUser();
  }

  void deleteCar() {
    _user.carList.removeAt(0);

    _updateUser();
  }

  void _updateUser() async {
    final prefs = await SharedPreferences.getInstance();

    final encode = jsonEncode(_user);
    await prefs.setString("user", encode);
  }
}
