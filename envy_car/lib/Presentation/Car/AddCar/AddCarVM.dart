import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class AddCarVM with ChangeNotifier {
  // AddCar
  String carName = '';
  Fuel fuel = Fuel.gasoline;
  DateTime startDate = DateTime.now();
  int mileage = 0;

  Color gasolineColor = Colors.blueGrey.shade900;
  Color dieselColor = Colors.transparent;
  String startBtnText = '관리시작일';
  String mileageBtnText = '현재 주행거리';
  bool get isEnabledConfirm => (carName != '' && mileage != 0);

  (String, Fuel, DateTime, int) get carModel =>
      (carName, fuel, startDate, mileage);

  makeCar() {
    List<Maintenance> list = [];

    if (fuel == Fuel.gasoline) {
      list = [
        Maintenance('엔진오일', 10000, 12, []),
        Maintenance('에어컨 필터', 15000, 12, []),
        Maintenance('미션오일', 60000, 12, []),
        Maintenance('배터리', 0, 60, []),
        Maintenance('브레이크 패드', 70000, 0, []),
        Maintenance('브레이크 오일', 50000, 0, []),
        Maintenance('구동벨트', 100000, 0, []),
        Maintenance('점화 플러그', 100000, 0, []),
        Maintenance('냉각수', 200000, 120, []),
        Maintenance('타이밍 벨트', 200000, 0, [])
      ];
    } else {}

    Car car = Car(carName, fuel, startDate, mileage, list);

    var manager = CarManager();
    manager.setCar(car);
  }

  void updateCarName(String value) {
    carName = value;
  }

  void updateFuel(Fuel value) {
    fuel = value;

    gasolineColor =
        value == Fuel.gasoline ? Colors.blueGrey.shade900 : Colors.transparent;
    dieselColor =
        value == Fuel.diesel ? Colors.blueGrey.shade900 : Colors.transparent;

    notifyListeners();
  }

  void updateSelectedDate(DateTime date) {
    startDate = date;

    startBtnText = DateFormat('yyyy-MM-dd').format(date);

    notifyListeners();
  }

  void updateMileage(String value) {
    mileage = int.tryParse(value) ?? 0;

    mileageBtnText = '${mileage.toNumberFormat()}km';

    notifyListeners();
  }
}
