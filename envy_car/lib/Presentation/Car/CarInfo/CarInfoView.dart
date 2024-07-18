import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Presentation/Custom/MaintenanceListTile.dart';
import 'package:envy_car/Presentation/Custom/PopUpMenu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CarInfoView extends StatefulWidget {
  const CarInfoView({super.key});

  @override
  State<CarInfoView> createState() => _CarInfoViewState();
}

class _CarInfoViewState extends State<CarInfoView> {
  final List<GlobalKey> _listTileKeys =
      List.generate(10, (index) => GlobalKey());
  double? _listTileHeight;

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getListTileHeight();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!Provider.of<CarInfoVM>(context, listen: false).isWeatherLoad) {
      Provider.of<CarInfoVM>(context, listen: true).getCurrentLocation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('차량 정보'),
          actions: const [PopupMenuWidget()],
        ),
        body: SingleChildScrollView(
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
                            const Text('차량 번호',
                                style: TextStyle(
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
                                    text: '휘발유',
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
                                if (Provider.of<CarInfoVM>(context,
                                        listen: false)
                                    .isWeatherLoad)
                                  Consumer<CarInfoVM>(
                                      builder: (context, value, child) {
                                    return Text(
                                      value.carwashMessage,
                                      style: const TextStyle(fontSize: 18),
                                    );
                                  }),
                                const SizedBox(width: 10),
                                if (Provider.of<CarInfoVM>(context,
                                        listen: false)
                                    .isWeatherLoad)
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
                                  onPressed: () {},
                                  child: const Text('누적 주행거리 +\n0km',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text('22.01.07 >\n0일째 관리중',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white))),
                              const Spacer()
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: (_listTileHeight ?? 0) * 10, // 리스트뷰의 높이를 지정
                child: ListView.builder(
                  shrinkWrap: true, // 스크롤 뷰와 충돌하지 않도록
                  physics:
                      const NeverScrollableScrollPhysics(), // 리스트뷰 자체의 스크롤 비활성화
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    const start = 0;
                    const now = 700;
                    const end = 100000;
                    const progress = now / (end - start);
                    const mileage = end - now;

                    return MaintenanceListTile(
                      key: _listTileKeys[index],
                      title: '엔진오일 $index',
                      subtitle: '${mileage.toNumberFormat()} km 또는 12개월 남음',
                      progress: progress,
                      start: start,
                      now: now,
                      end: end,
                    );
                  },
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text('차량 삭제',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey.shade700))),
              const SizedBox(height: 10)
            ],
          ),
        ));
  }
}
