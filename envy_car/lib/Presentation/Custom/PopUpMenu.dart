import 'package:envy_car/Presentation/Car/AddCar/AddCarView.dart';
import 'package:flutter/material.dart';

class PopupMenuWidget extends StatelessWidget {
  const PopupMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.list),
      itemBuilder: (BuildContext context) {
        return [PopupMenuItem(value: '차량추가', child: Text('차량추가'))];
        // return [
        //   for (final value in PopupMenu.values)
        //     PopupMenuItem(value: value, child: Text(value.title))
        // ];
      },
      onSelected: (value) => {
        print(value),
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddCarView()))
      },
    );
  }
}
