import 'package:envy_car/Presentation/Car/AddCar/AddCarView.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoView.dart';
import 'package:envy_car/Presentation/Login/LoginVM.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const AddCarView()),
                );
              },
              child: const Text('로그인 없이 시작'))
        ],
      ),
      body: SafeArea(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
            const Spacer(),
            Image.asset(
              'assets/icon.png',
              width: 100, // 이미지 가로 크기
              height: 100,
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    context.read<LoginVM>().signInWithApple();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/alogo.png',
                        width: 35,
                        height: 35,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Apple로 로그인',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )
                    ],
                  )),
            ),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await context.read<LoginVM>().signInWithGoogle();
                      await context.read<LoginVM>().roadFirebase();

                      if (CarManager().user.carList.isEmpty) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddCarView()));
                      } else {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CarInfoView()));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                        ) // 배경색 설정
                        ),
                    child: Row(
                      //spaceEvenly: 요소들을 균등하게 배치하는 속성
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/glogo.png',
                          width: 15, // 이미지 가로 크기
                          height: 15,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Google로 로그인',
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )
                      ],
                    ))),
            const SizedBox(height: 15),
          ]))),
    );
  }
}
