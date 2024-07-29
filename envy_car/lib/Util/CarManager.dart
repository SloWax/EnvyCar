import 'dart:convert';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CarManager {
  // 정적 변수로 싱글톤 인스턴스를 저장
  static final CarManager _instance = CarManager._internal();

  Car _car = Car('', Fuel.gasoline, DateTime.now(), 0, []);

  Car get car => _car;

  // 팩토리 생성자는 기존 인스턴스를 반환
  factory CarManager() {
    return _instance;
  }

  // private 생성자로 내부에서만 호출 가능
  CarManager._internal();

  // 싱글톤 클래스의 메서드와 속성을 여기에 정의
  void setCar(Car value) {
    _car = value;

    _saveUser();
  }

  void _saveUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString("user");

    User user;

    if (userJson != null) {
      final decode = jsonDecode(userJson);
      user = User.fromJson(decode);
      user.carList.insert(0, _car);
    } else {
      user = User('user', [_car]);
    }

    final encode = jsonEncode(user);
    await prefs.setString("user", encode);
  }

// void initPrefereneces() async {
//     final prefs = await SharedPreferences.getInstance();
//     var data = prefs.getString("todos");
//     if (data != null) {
//       final decode = jsonDecode(data);
//       if (decode is List<dynamic>) {
//         for (final e in decode) {
//           _todos.add(Todo.fromJson(e));
//         }
//       }
//     }
//   }
}
