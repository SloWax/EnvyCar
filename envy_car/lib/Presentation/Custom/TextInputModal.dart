import 'package:envy_car/Presentation/Car/AddCar/AddCarVM.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  DateTime? selectedDate;

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
                firstDate: DateTime(2000),
                lastDate: DateTime(2101),
              );
              if (picked != null && picked != selectedDate) {
                setState(() {
                  selectedDate = picked;
                });
              }
            },
            child: const Text('날짜 선택'),
          ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('취소'),
        ),
        TextButton(
          onPressed: () {
            // Handle input here
            String number = numberController.text;
            print('Number: $number, Date: ${selectedDate.toString()}');

            if (widget.modalKey == ModalKey.addCar) {
              context.read<AddCarVM>().updateMileage(numberController.text);
            } else if (widget.modalKey == ModalKey.maintenanceAdd) {
            } else if (widget.modalKey == ModalKey.maintenanceMile) {
            } else if (widget.modalKey == ModalKey.maintenanceCycle) {}

            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('입력'),
        ),
      ],
    );
  }
}
