import 'package:envy_car/Presentation/Car/AddCar/AddCarVM.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleVM.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleView.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:envy_car/Extension/Extension+string.dart';

class TextInputModal extends StatefulWidget {
  final ModalKey modalKey;
  final String title;
  final String decoration;
  final bool isHiddenDate;

  const TextInputModal(
      {super.key,
      required this.modalKey,
      required this.title,
      required this.decoration,
      required this.isHiddenDate});

  @override
  _TextInputModalState createState() => _TextInputModalState();
}

class _TextInputModalState extends State<TextInputModal> {
  final TextEditingController numberController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: numberController,
            decoration: InputDecoration(labelText: widget.decoration),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 10),
        ],
      ),
      actions: [
        if (!widget.isHiddenDate)
          TextButton(
            onPressed: () async {
              DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            child: Text(DateFormat('yyyy-MM-dd').format(selectedDate)),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            String number = numberController.text;
            print('Number: $number, Date: ${selectedDate.toString()}');

            if (widget.modalKey == ModalKey.addCar) {
              context.read<AddCarVM>().updateMileage(number.toInt());
            } else if (widget.modalKey == ModalKey.mileageSet) {
              context.read<CarInfoVM>().setMilege(number.toInt());
            } else if (widget.modalKey == ModalKey.maintenanceAdd) {
              context
                  .read<MaintenanceArticleVM>()
                  .addArticle(number.toInt(), selectedDate);
            } else if (widget.modalKey == ModalKey.maintenanceMile) {
              context.read<MaintenanceArticleVM>().setMileage(number.toInt());
            } else if (widget.modalKey == ModalKey.maintenanceCycle) {
              context.read<MaintenanceArticleVM>().setCycle(number.toInt());
            }

            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('입력'),
        ),
      ],
    );
  }
}
