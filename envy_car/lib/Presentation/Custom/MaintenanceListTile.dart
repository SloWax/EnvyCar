import 'package:envy_car/Extension/Extension+int.dart';
import 'package:envy_car/Presentation/Model/CarModel.dart';
import 'package:flutter/material.dart';

class MaintenanceListTile extends StatelessWidget {
  final Maintenance data;
  final int mileage;
  final DateTime manageDate;
  final VoidCallback onTap;

  const MaintenanceListTile(
      {super.key,
      required this.data,
      required this.mileage,
      required this.manageDate,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    final title = data.name;
    final startMile = data.history.isEmpty ? 0 : data.history.first.mileage;
    final nowMile = mileage;
    final endMile = startMile + data.maintenanceMile;
    final startDate =
        data.history.isEmpty ? manageDate : data.history.last.date;
    final nowDate = DateTime.now().difference(startDate).inDays ~/ 30;
    final endDate = data.maintenanceCycle;

    String subtitle, progressStart, progressEnd;
    int start, end, remainingMile, remainingDate;
    double progress;
    bool isOver;

    if (data.maintenanceMile != 0) {
      start = startMile;
      end = endMile;
      remainingMile = endMile - nowMile;
      remainingDate = endDate - nowDate;

      if (data.maintenanceCycle != 0) {
        isOver = (remainingMile <= 0 || remainingDate <= 0);
      } else {
        isOver = remainingMile <= 0;
      }
      progress = isOver ? 1.0 : (nowMile - startMile) / (endMile - startMile);

      if (remainingMile <= 0) {
        subtitle = '${remainingMile.toNumberFormat()}km 지남';
      } else if (remainingDate <= 0 && data.maintenanceCycle != 0) {
        subtitle = '${remainingDate * -1}개월 지남';
      } else if (data.maintenanceCycle != 0) {
        subtitle = '${remainingMile.toNumberFormat()}km 또는 $remainingDate개월 남음';
      } else {
        subtitle = '${remainingMile.toNumberFormat()}km 남음';
      }

      progressStart = '${start.toNumberFormat()}km';
      progressEnd = '${end.toNumberFormat()}km';
    } else {
      start = 0;
      end = data.maintenanceCycle;
      remainingMile = endMile - nowMile;
      remainingDate = endDate - nowDate;
      subtitle = remainingDate <= 0
          ? '${remainingDate * -1}개월 지남'
          : '$remainingDate개월 남음';
      progress = remainingDate <= 0 ? 1.0 : nowDate / endDate;
      progressStart = '${start.toNumberFormat()}개월';
      progressEnd = '${end.toNumberFormat()}개월';
    }

    return InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(title),
                subtitle: Text(subtitle, style: const TextStyle(fontSize: 18)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: LinearProgressIndicator(
                  color: progress == 1 ? Colors.red.shade900 : Colors.blueGrey,
                  value: progress, // 프로그레스 값 설정
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(progressStart, style: const TextStyle(fontSize: 12)),
                      Text(progressEnd, style: const TextStyle(fontSize: 12))
                    ],
                  ))
            ],
          ),
        ));
  }
}
