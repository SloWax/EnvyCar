import 'package:envy_car/Presentation/Custom/TextInputModal.dart';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';

class MaintenanceArticleView extends StatefulWidget {
  final Maintenance data;
  const MaintenanceArticleView({super.key, required this.data});

  @override
  State<MaintenanceArticleView> createState() => _MaintenanceArticleViewState();
}

class _MaintenanceArticleViewState extends State<MaintenanceArticleView> {
  late List<GlobalKey> _listTileKeys;
  double? _listTileHeight;

  @override
  void initState() {
    super.initState();

    // manager의 변수를 참조하여 _listTileKeys를 초기화
    _listTileKeys = List.generate(
      widget.data.history.length,
      (index) => GlobalKey(),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.data.history.length > 0) {
        _getListTileHeight();
      }
    });
  }

  void _getListTileHeight() {
    final renderBox =
        _listTileKeys.first.currentContext?.findRenderObject() as RenderBox;
    final height = renderBox.size.height;
    setState(() {
      _listTileHeight = height;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('오일오일'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const TextInputModal(
                        modalKey: ModalKey.maintenanceAdd,
                        title: '오일오일',
                        decoration: 'km',
                        isHiddenDate: false);
                  },
                );
              },
            )
          ],
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
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('점검 주기',
                                style: TextStyle(
                                    fontSize: 24, fontWeight: FontWeight.bold))
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
                                            modalKey: ModalKey.maintenanceMile,
                                            title: '거리 설정',
                                            decoration: 'km',
                                            isHiddenDate: true);
                                      },
                                    );
                                  },
                                  child: const Text('거리\n0km',
                                      style: TextStyle(fontSize: 18))),
                              const Spacer(),
                              TextButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return const TextInputModal(
                                            modalKey: ModalKey.maintenanceCycle,
                                            title: '주기 설정',
                                            decoration: '개월',
                                            isHiddenDate: true);
                                      },
                                    );
                                  },
                                  child: const Text('주기\n0개월',
                                      style: TextStyle(fontSize: 18))),
                              const Spacer()
                            ],
                          ))
                    ],
                  )),
              const SizedBox(height: 10),
              SizedBox(
                height: (_listTileHeight ?? 0) *
                    widget.data.history.length, // 리스트뷰의 높이를 지정
                child: ListView.builder(
                  shrinkWrap: true, // 스크롤 뷰와 충돌하지 않도록
                  physics:
                      const NeverScrollableScrollPhysics(), // 리스트뷰 자체의 스크롤 비활성화
                  itemCount: widget.data.history.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                        key: Key('$index'), // 각 항목의 고유 키
                        background: Container(
                          color: Colors.red, // 스와이프할 때 보여줄 배경
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        direction:
                            DismissDirection.endToStart, // 오른쪽에서 왼쪽으로 스와이프
                        onDismissed: (direction) {
                          setState(() {
                            // _items.removeAt(index); // 항목 제거
                          });

                          // 스낵바로 제거 알림
                          ScaffoldMessenger.of(context).showSnackBar(
                            // SnackBar(content: Text('${_items[index]} 제거됨')),
                            const SnackBar(content: Text('제거됨')),
                          );
                        },
                        child: ListTile(
                          key: _listTileKeys[index],
                          // title: Text(_items[index]),
                          title: const Text('날짜 / 주행거리'),
                        ));
                    // ListTile(
                    //     key: _listTileKeys[index], title: const Text('날짜 / 주행거리'));
                  },
                ),
              )
            ],
          ),
        ));
  }
}
