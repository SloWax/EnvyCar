import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';

class MaintenanceArticleVM with ChangeNotifier {
  late int _dataIndex;

  void setIndex(int value) {
    _dataIndex = value;
  }

  void setMileage(int mileage) {
    final data = CarManager().car.maintenanceList[_dataIndex];
    final newCar = CarManager().car;

    data.maintenanceMile = mileage;
    newCar.maintenanceList[_dataIndex] = data;

    CarManager().updateCar(newCar);

    notifyListeners();
  }

  void setCycle(int cycle) {
    final data = CarManager().car.maintenanceList[_dataIndex];
    final newCar = CarManager().car;

    data.maintenanceCycle = cycle;
    newCar.maintenanceList[_dataIndex] = data;

    CarManager().updateCar(newCar);

    notifyListeners();
  }

  void addArticle(int mileage, DateTime date) {
    final data = CarManager().car.maintenanceList[_dataIndex];
    final history = MaintenanceHistory(date, mileage);
    final newCar = CarManager().car;

    data.history.add(history);
    newCar.maintenanceList[_dataIndex] = data;
    newCar.maintenanceList[_dataIndex].history
        .sort((a, b) => b.date.compareTo(a.date));

    CarManager().updateCar(newCar);

    notifyListeners();
  }

  void deleteArticle(int index) {
    final data = CarManager().car.maintenanceList[_dataIndex];
    final newCar = CarManager().car;

    data.history.removeAt(index);
    newCar.maintenanceList[_dataIndex] = data;

    CarManager().updateCar(newCar);

    notifyListeners();
  }
}
