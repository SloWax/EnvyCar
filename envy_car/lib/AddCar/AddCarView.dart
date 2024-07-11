import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddCarView extends StatelessWidget {
  const AddCarView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('차량 등록'),
        actions: [
          Visibility(
              visible: true,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ))
        ],
      ),
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: const TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(hintText: '차량번호 or 애칭'),
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
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      side: BorderSide(width: 1, color: Colors.yellow.shade700),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.yellow.shade700),
                  onPressed: () {},
                  child:
                      const Text('Gasoline\n휘발유', textAlign: TextAlign.center),
                ),
              )),
              Expanded(
                  child: Container(
                margin: const EdgeInsets.only(left: 15.0, right: 30.0),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.only(top: 5, bottom: 5),
                        side: BorderSide(
                            width: 1.5, color: Colors.green.shade900),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        foregroundColor: Colors.green.shade900),
                    onPressed: () {},
                    child:
                        const Text('Diesel\n경유', textAlign: TextAlign.center)),
              ))
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      side:
                          BorderSide(width: 1, color: Colors.blueGrey.shade200),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.blueGrey.shade200),
                  onPressed: () {},
                  child: const Text('관리시작일'))),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      side:
                          BorderSide(width: 1, color: Colors.blueGrey.shade200),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      foregroundColor: Colors.blueGrey.shade200),
                  onPressed: () {},
                  child: const Text('현재 주행거리'))),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0),
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('설정 완료'))),
          const SizedBox(
            height: 15,
          )
        ],
      )),
    );
  }
}
