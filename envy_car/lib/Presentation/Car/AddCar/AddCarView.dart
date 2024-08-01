import 'package:envy_car/Presentation/Car/AddCar/AddCarVM.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoView.dart';
import 'package:envy_car/Presentation/Custom/TextInputModal.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCarView extends StatelessWidget {
  const AddCarView({super.key});

  void pushNext(BuildContext context) {
    context.read<AddCarVM>().makeCar();

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const CarInfoView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('차량 등록'),
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextField(
                onChanged: (value) {
                  context.read<AddCarVM>().updateCarName(value);
                },
                textAlign: TextAlign.center,
                decoration: const InputDecoration(hintText: '차량번호 or 애칭'),
              )),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 30.0, right: 15.0),
                child: Consumer<AddCarVM>(builder: (context, model, child) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        side:
                            BorderSide(width: 1, color: Colors.yellow.shade700),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.yellow.shade700,
                        backgroundColor: model.gasolineColor),
                    onPressed: () {
                      context.read<AddCarVM>().updateFuel(Fuel.gasoline);
                    },
                    child: const Text('Gasoline\n휘발유',
                        textAlign: TextAlign.center),
                  );
                }),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: Consumer<AddCarVM>(builder: (context, model, child) {
                  return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        side: BorderSide(
                            width: 1.5, color: Colors.green.shade900),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.green.shade900,
                        backgroundColor: model.dieselColor),
                    onPressed: () {
                      context.read<AddCarVM>().updateFuel(Fuel.diesel);
                    },
                    child:
                        const Text('Diesel\n경유', textAlign: TextAlign.center),
                  );
                }),
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Consumer<AddCarVM>(builder: (context, model, child) {
                return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        side: BorderSide(
                            width: 1, color: Colors.blueGrey.shade200),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.blueGrey.shade200),
                    onPressed: () async {
                      DateTime? selectedDate = await showDatePicker(
                        context: context,
                        initialDate: context.read<AddCarVM>().startDate,
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2101),
                      );
                      if (selectedDate != null) {
                        context
                            .read<AddCarVM>()
                            .updateSelectedDate(selectedDate);
                      }
                    },
                    child: Text(model.startBtnText));
              })),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Consumer<AddCarVM>(builder: (context, model, child) {
                return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        side: BorderSide(
                            width: 1, color: Colors.blueGrey.shade200),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.blueGrey.shade200),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const TextInputModal(
                              modalKey: ModalKey.addCar,
                              title: '현재 주행거리',
                              decoration: 'km',
                              isHiddenDate: true);
                        },
                      );
                    },
                    child: Text(model.mileageBtnText));
              })),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Consumer<AddCarVM>(builder: (context, model, child) {
                return ElevatedButton(
                    onPressed:
                        model.isEnabledConfirm ? () => pushNext(context) : null,
                    child: const Text('설정 완료'));
              })),
          const SizedBox(height: 15)
        ],
      )),
    );
  }
}
