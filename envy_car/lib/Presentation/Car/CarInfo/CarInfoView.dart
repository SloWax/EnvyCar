import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleVM.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleView.dart';
import 'package:envy_car/Presentation/Custom/MaintenanceListTile.dart';
import 'package:envy_car/Presentation/Custom/PopUpMenu.dart';
import 'package:envy_car/Presentation/Custom/TextInputModal.dart';
import 'package:envy_car/Presentation/Login/LoginView.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CarInfoView extends StatefulWidget {
  const CarInfoView({super.key});

  @override
  State<CarInfoView> createState() => _CarInfoViewState();
}

class _CarInfoViewState extends State<CarInfoView> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Consumer<CarInfoVM>(builder: (context, vm, child) {
            return IconButton(
              icon: CarManager().token != 'user'
                  ? const Icon(Icons.cloud_done)
                  : const Icon(Icons.cloud),
              onPressed: () {
                if (CarManager().token != 'user') {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('동기화 해제',
                            style: TextStyle(fontSize: 24)),
                        content: const Text(
                            '동기화 해제를 하면 계정이 삭제되고 백업된 정보가 사라지게 됩니다.\n동기화를 해제할까요?',
                            style: TextStyle(fontSize: 18)),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('해제',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.red)),
                            onPressed: () {
                              context.read<CarInfoVM>().logout();

                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text('아니오',
                                style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                  print('connected');
                } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LoginView(isFirst: false)));
                  print('not connect');
                }
              },
            );
          }),
          title: const Text('차량 정보'),
          actions: const [PopupMenuWidget()],
        ),
        body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade900,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Consumer<CarInfoVM>(builder: (context, vm, child) {
                              return Text(CarManager().car.carName,
                                  style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold));
                            }),
                            const SizedBox(height: 10),
                            Consumer<CarInfoVM>(builder: (context, vm, child) {
                              return RichText(
                                text: TextSpan(
                                  children: [
                                    const TextSpan(
                                      text: '유종 ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextSpan(
                                      text:
                                          CarManager().car.fuel == Fuel.gasoline
                                              ? '휘발유'
                                              : '경유',
                                      style: TextStyle(
                                          color: CarManager().car.fuel ==
                                                  Fuel.gasoline
                                              ? Colors.yellow.shade700
                                              : Colors.green.shade900,
                                          fontSize: 18),
                                    ),
                                  ],
                                ),
                              );
                            }),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  'assets/WeatherIcon/${CarManager().result.icon}@2x.png', // 이미지 경로
                                  height: 24, // 텍스트 높이에 맞춘 이미지 높이
                                  width: 24, // 이미지의 너비도 높이와 같게 설정
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  CarManager().carwashMessage,
                                  style: const TextStyle(fontSize: 18),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            color: Colors.grey.shade800,
                          ),
                          child: Row(
                            children: [
                              Consumer<CarInfoVM>(
                                  builder: (context, vm, child) {
                                return TextButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const TextInputModal(
                                              modalKey: ModalKey.mileageSet,
                                              title: '주행거리',
                                              decoration: 'km',
                                              isHiddenDate: true);
                                        },
                                      );
                                    },
                                    child: Text(
                                        '누적 주행거리 +\n${CarManager().car.mileage.toNumberFormat()}km',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white)));
                              }),
                              const Spacer(),
                              Consumer<CarInfoVM>(
                                  builder: (context, vm, child) {
                                return TextButton(
                                    onPressed: () async {
                                      DateTime? selectedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate:
                                            CarManager().car.manageDate,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2101),
                                      );
                                      if (selectedDate != null) {
                                        context
                                            .read<CarInfoVM>()
                                            .setDate(selectedDate);
                                      }
                                    },
                                    child: Text(
                                        '${DateFormat('yy.MM.dd').format(CarManager().car.manageDate)} >\n${DateTime.now().difference(CarManager().car.manageDate).inDays}일째 관리중',
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white)));
                              }),
                              const Spacer()
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 10),
              Consumer<CarInfoVM>(builder: (context, vm, child) {
                return Consumer<MaintenanceArticleVM>(
                    builder: (context, articleVM, child) {
                  return ListView.builder(
                    shrinkWrap: true, // 스크롤 뷰와 충돌하지 않도록
                    physics:
                        const NeverScrollableScrollPhysics(), // 리스트뷰 자체의 스크롤 비활성화
                    itemCount: CarManager().car.maintenanceList.length,
                    itemBuilder: (context, index) {
                      return MaintenanceListTile(
                        data: CarManager().car.maintenanceList[index],
                        mileage: CarManager().car.mileage,
                        manageDate: CarManager().car.manageDate,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MaintenanceArticleView(
                                      dataIndex: index)));
                        },
                      );
                    },
                  );
                });
              }),
              Visibility(
                visible: CarManager().user.carList.length > 1,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('차량 삭제',
                                style: TextStyle(fontSize: 24)),
                            content: Text(
                                '${CarManager().car.carName}\n차량을 삭제할까요?',
                                style: const TextStyle(fontSize: 18)),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('삭제',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.red)),
                                onPressed: () {
                                  context.read<CarInfoVM>().deleteCar();

                                  _scrollController.jumpTo(0.0);

                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: const Text('아니오',
                                    style: TextStyle(fontSize: 18)),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Text('차량 삭제',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade700))),
              ),
              const SizedBox(height: 10)
            ],
          ),
        ));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
