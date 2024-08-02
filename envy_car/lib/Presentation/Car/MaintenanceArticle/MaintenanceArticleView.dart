import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleVM.dart';
import 'package:envy_car/Presentation/Custom/TextInputModal.dart';
import 'package:envy_car/Presentation/Model/Enum.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MaintenanceArticleView extends StatefulWidget {
  final int dataIndex;
  const MaintenanceArticleView({super.key, required this.dataIndex});

  @override
  State<MaintenanceArticleView> createState() => _MaintenanceArticleViewState();
}

class _MaintenanceArticleViewState extends State<MaintenanceArticleView> {
  @override
  void initState() {
    super.initState();

    Provider.of<MaintenanceArticleVM>(context, listen: false)
        .setIndex(widget.dataIndex);
  }

  @override
  Widget build(BuildContext context) {
    final maintenance = CarManager().car.maintenanceList[widget.dataIndex];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(maintenance.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const TextInputModal(
                      modalKey: ModalKey.maintenanceAdd,
                      title: '정비 내역',
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
                      child: Consumer<MaintenanceArticleVM>(
                          builder: (context, vm, child) {
                        return Row(
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
                              child: Text(
                                  '거리\n${maintenance.maintenanceMile.toNumberFormat()}km',
                                  style: const TextStyle(fontSize: 18)),
                            ),
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
                              child: Text(
                                  '주기\n${maintenance.maintenanceCycle}개월',
                                  style: const TextStyle(fontSize: 18)),
                            ),
                            const Spacer()
                          ],
                        );
                      }))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Consumer<MaintenanceArticleVM>(
              builder: (context, vm, child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: CarManager()
                      .car
                      .maintenanceList[widget.dataIndex]
                      .history
                      .length,
                  itemBuilder: (context, index) {
                    final date = DateFormat('yyyy-MM-dd')
                        .format(maintenance.history[index].date);
                    final km =
                        maintenance.history[index].mileage.toNumberFormat();
                    final title = '$date / ${km}km';

                    return Dismissible(
                      key: Key(title),
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        context
                            .read<MaintenanceArticleVM>()
                            .deleteArticle(index);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('제거됨')),
                        );
                      },
                      child: ListTile(
                        title: Text(title),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
