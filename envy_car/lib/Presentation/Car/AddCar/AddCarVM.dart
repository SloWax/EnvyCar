import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
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
