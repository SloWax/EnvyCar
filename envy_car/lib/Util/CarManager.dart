import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';

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
  }
}
