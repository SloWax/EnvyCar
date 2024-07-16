import 'package:envy_car/Extension/Extension+int.dart';
import 'package:flutter/material.dart';

class MaintenanceListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final double progress;
  final int start;
  final int now;
  final int end;

  const MaintenanceListTile(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.progress,
      required this.start,
      required this.now,
      required this.end});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              color: Colors.blueGrey,
              value: progress, // 프로그레스 값 설정
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${start.toNumberFormat()}km',
                      style: const TextStyle(fontSize: 12)),
                  Text('${end.toNumberFormat()}km',
                      style: const TextStyle(fontSize: 12))
                ],
              ))
        ],
      ),
    );
  }
}
