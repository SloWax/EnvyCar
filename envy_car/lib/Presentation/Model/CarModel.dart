import 'package:envy_car/Presentation/Model/Enum.dart';

class Car {
  String carName;
  Fuel fuel;
  DateTime manageDate;
  int mileage;

  List<Maintenance> maintenanceList;

  Car(this.carName, this.fuel, this.manageDate, this.mileage,
      this.maintenanceList);
}

class Maintenance {
  String name;
  int maintenanceMile;
  int maintenanceCycle;

  List<MaintenanceHistory> history = [];

  Maintenance(this.name, this.maintenanceMile, this.maintenanceCycle);
}

class MaintenanceHistory {
  DateTime date = DateTime.now();
  int mileage;

  MaintenanceHistory(this.date, this.mileage);
}
