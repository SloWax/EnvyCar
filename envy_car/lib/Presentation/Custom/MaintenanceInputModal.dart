import 'package:flutter/material.dart';

class MaintenanceInputModal extends StatefulWidget {
  final String title;
  final String decoration;
  final bool isHiddenDate;

  const MaintenanceInputModal(
      {super.key,
      required this.title,
      required this.decoration,
      required this.isHiddenDate});

  @override
  _MaintenanceInputModalState createState() => _MaintenanceInputModalState();
}

class _MaintenanceInputModalState extends State<MaintenanceInputModal> {
  final TextEditingController numberController = TextEditingController();
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

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
            onPressed: () => _selectDate(context),
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
            Navigator.of(context).pop(); // Close the modal
          },
          child: const Text('입력'),
        ),
      ],
    );
  }
}
