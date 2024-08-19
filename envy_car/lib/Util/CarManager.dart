import 'dart:convert';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/WeatherModel.dart';
import 'package:envy_car/Util/FirebaseManager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarManager {
  // 정적 변수로 싱글톤 인스턴스를 저장
  static final CarManager _instance = CarManager._internal();

  String _token = 'user';
  CarUser _user = CarUser('user', []);

  String get token => _token;
  CarUser get user => _user;
  Car get car => _user.carList.first;

  Weather result = Weather(0.0, 0.0, 0, '', '', 0.0);
  String carwashMessage = "";

  // 팩토리 생성자는 기존 인스턴스를 반환
  factory CarManager() {
    return _instance;
  }

  // private 생성자로 내부에서만 호출 가능
  CarManager._internal();

  void setToken(String value) async {
    _token = value;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _token);
  }

  void setUser(CarUser value) {
    _user = value;
  }

  Future<String> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString("token") ?? "user";

    return _token;
  }

  Future<String?> loadUser(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(token);

    if (userJson != null) {
      final decode = jsonDecode(userJson);
      _user = CarUser.fromJson(decode);
    }

    return userJson;
  }

  void addCar(Car value) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_token);

    if (userJson != null) {
      final decode = jsonDecode(userJson);
      _user = CarUser.fromJson(decode);
    }

    _user.carList.insert(0, value);

    updateUser();
  }

  void updateCar(Car value) {
    _user.carList[0] = value;

    updateUser();
  }

  void changeCar(Car value, int index) {
    _user.carList.removeAt(index);
    _user.carList.insert(0, value);

    updateUser();
  }

  void deleteCar() {
    _user.carList.removeAt(0);

    updateUser();
  }

  void updateUser() async {
    final prefs = await SharedPreferences.getInstance();

    _user.user = _token;
    await prefs.setString('token', _token);

    final encode = jsonEncode(_user);
    await prefs.setString(_token, encode);

    if (_token != 'user') {
      FirebaseManager().backupFirebase(_token, encode);
    }
  }
}
