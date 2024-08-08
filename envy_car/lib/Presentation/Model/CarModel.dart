import 'package:envy_car/Presentation/Model/Enum.dart';

class CarUser {
  String user;
  List<Car> carList;

  CarUser(this.user, this.carList);

  factory CarUser.fromJson(Map<String, dynamic> json) {
    return CarUser(
      json['user'],
      (json['carList'] as List).map((item) => Car.fromJson(item)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'carList': carList.map((item) => item.toJson()).toList(),
    };
  }
}

class Car {
  String carName;
  Fuel fuel;
  DateTime manageDate;
  int mileage;

  List<Maintenance> maintenanceList;

  Car(this.carName, this.fuel, this.manageDate, this.mileage,
      this.maintenanceList);

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      json['carName'],
      Fuel.values[json['fuel']],
      DateTime.parse(json['manageDate']),
      json['mileage'],
      (json['maintenanceList'] as List)
          .map((item) => Maintenance.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carName': carName,
      'fuel': fuel.index,
      'manageDate': manageDate.toIso8601String(),
      'mileage': mileage,
      'maintenanceList': maintenanceList.map((item) => item.toJson()).toList(),
    };
  }
}

class Maintenance {
  String name;
  int maintenanceMile;
  int maintenanceCycle;

  List<MaintenanceHistory> history = [];

  Maintenance(
      this.name, this.maintenanceMile, this.maintenanceCycle, this.history);

  factory Maintenance.fromJson(Map<String, dynamic> json) {
    return Maintenance(
      json['name'],
      json['maintenanceMile'],
      json['maintenanceCycle'],
      (json['history'] as List)
          .map((item) => MaintenanceHistory.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'maintenanceMile': maintenanceMile,
      'maintenanceCycle': maintenanceCycle,
      'history': history.map((item) => item.toJson()).toList(),
    };
  }
}

class MaintenanceHistory {
  DateTime date;
  int mileage;

  MaintenanceHistory(this.date, this.mileage);

  factory MaintenanceHistory.fromJson(Map<String, dynamic> json) {
    return MaintenanceHistory(
      DateTime.parse(json['date']),
      json['mileage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'mileage': mileage,
    };
  }
}
