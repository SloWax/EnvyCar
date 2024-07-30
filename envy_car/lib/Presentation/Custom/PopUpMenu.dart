import 'package:envy_car/Presentation/Car/AddCar/AddCarView.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.list),
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<String>> buttons = [];

        final manager = CarManager();
        final user = manager.user;

        if (user.carList.length > 1) {
          for (final value in user.carList) {
            var button =
                PopupMenuItem(value: value.carName, child: Text(value.carName));
            buttons.add(button);
          }
        }

        buttons.add(const PopupMenuItem(value: '차량추가', child: Text('차량추가')));

        return buttons;
      },
      onSelected: (value) {
        if (value == '차량추가') {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddCarView()));
        } else {
          var manager = CarManager();
          var list = manager.user.carList;
          int index = list.indexWhere((car) => car.carName == value);

          context.read<CarInfoVM>().changeCar(list[index], index);
        }
      },
    );
  }
}
