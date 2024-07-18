import 'package:envy_car/Presentation/Model/Enum.dart';

class Car {
  String carName = '';
  Fuel fuel = Fuel.gasoline;
  DateTime startDate = DateTime.now();
  int mileage = 0;

  Car(this.carName, this.fuel, this.startDate, this.mileage);
}

class Maintenance {
  String name = '';
  int startMile = 0;
  int endMile = 0;
}
