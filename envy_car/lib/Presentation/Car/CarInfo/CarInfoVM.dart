import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';

class CarInfoVM with ChangeNotifier {
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
