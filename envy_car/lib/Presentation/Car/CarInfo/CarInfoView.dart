import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleView.dart';
import 'package:envy_car/Presentation/Custom/MaintenanceListTile.dart';
import 'package:envy_car/Presentation/Custom/PopUpMenu.dart';
import 'package:envy_car/Presentation/Custom/TextInputModal.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarInfoView extends StatefulWidget {
  const CarInfoView({super.key});

  @override
  State<CarInfoView> createState() => _CarInfoViewState();
}

class _CarInfoViewState extends State<CarInfoView> {
  late CarManager manager;
  late List<GlobalKey> _listTileKeys;
  double? _listTileHeight;
  final ScrollController _scrollController = ScrollController();

  void _getListTileHeight() {
    final renderBox = _listTileKeys.first.currentContext?.findRenderObject();

    if (renderBox is RenderBox) {
      final height = renderBox.size.height;
      setState(() {
        _listTileHeight = height;
      });
    }
  }

  @override
  void initState() {
    super.initState();

    manager = CarManager();

    // manager의 변수를 참조하여 _listTileKeys를 초기화
    _listTileKeys = List.generate(
      manager.car.maintenanceList.length,
      (index) => GlobalKey(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getListTileHeight();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!context.read<CarInfoVM>().isWeatherLoad) {
      Provider.of<CarInfoVM>(context, listen: true).getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    Duration difference = DateTime.now().difference(manager.car.manageDate);
    final mileage = manager.car.mileage;
    final date = difference.inDays;
    final list = manager.car.maintenanceList;

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
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
                            Text(manager.car.carName,
                                style: const TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            RichText(
                              text: TextSpan(
                                children: [
                                  const TextSpan(
                                    text: '유종 ',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  TextSpan(
                                    text: manager.car.fuel == Fuel.gasoline
                                        ? '휘발유'
                                        : '경유',
                                    style: TextStyle(
                                        color: Colors.yellow.shade700,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (context.read<CarInfoVM>().isWeatherLoad)
                                  Consumer<CarInfoVM>(
                                      builder: (context, value, child) {
                                    return Text(
                                      value.carwashMessage,
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  }),
                                const SizedBox(width: 10),
                                if (context.read<CarInfoVM>().isWeatherLoad)
                                  Consumer<CarInfoVM>(
                                      builder: (context, value, child) {
                                    return Image.asset(
                                      'assets/WeatherIcon/${value.result.icon}@2x.png', // 이미지 경로
                                      height: 24, // 텍스트 높이에 맞춘 이미지 높이
                                      width: 24, // 이미지의 너비도 높이와 같게 설정
                                    );
                                  }),
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
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const TextInputModal(
                                            modalKey: ModalKey.mileageSet,
                                            title: '정비 내역',
                                            decoration: 'km',
                                            isHiddenDate: true);
                                      },
                                    );
                                  },
                                  child: Text(
                                      '누적 주행거리 +\n${mileage.toNumberFormat()}km',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white))),
                              const Spacer(),
                              TextButton(
                                  onPressed: () async {
                                    DateTime? selectedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: manager.car.manageDate,
                                      firstDate: DateTime(1900),
                                      lastDate: DateTime(2101),
                                    );
                                    if (selectedDate != null) {
                                      context
                                          .read<CarInfoVM>()
                                          .setDate(selectedDate);
                                    }
                                  },
                                  child: Text('22.01.07 >\n$date일째 관리중',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.white))),
                              const Spacer()
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: (_listTileHeight ?? 0) * list.length, // 리스트뷰의 높이를 지정
                child: ListView.builder(
                  shrinkWrap: true, // 스크롤 뷰와 충돌하지 않도록
                  physics:
                      const NeverScrollableScrollPhysics(), // 리스트뷰 자체의 스크롤 비활성화
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return MaintenanceListTile(
                      key: _listTileKeys[index],
                      data: list[index],
                      mileage: mileage,
                      manageDate: manager.car.manageDate,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    MaintenanceArticleView(data: list[index])));
                      },
                    );
                  },
                ),
              ),
              Visibility(
                visible: manager.user.carList.length > 1,
                child: TextButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('차량 삭제',
                                style: TextStyle(fontSize: 24)),
                            content: Text('${manager.car.carName}\n차량을 삭제할까요?',
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
