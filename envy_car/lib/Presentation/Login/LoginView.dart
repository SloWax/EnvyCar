import 'dart:io';
import 'package:envy_car/Presentation/Car/AddCar/AddCarView.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoView.dart';
import 'package:envy_car/Presentation/Login/LoginVM.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:envy_car/Util/FirebaseManager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  final bool isFirst;

  const LoginView({super.key, required this.isFirst});

  void pushNext(BuildContext context) async {
    switch (isFirst) {
      case true:
        final email = await CarManager().loadToken();
        await FirebaseManager().roadFirebase(email);
        break;
      case false:
        CarManager().updateUser();
        break;
    }

    if (CarManager().user.carList.isEmpty && isFirst) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AddCarView()));
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CarInfoView()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('로그인'),
        centerTitle: true,
        actions: [
          if (isFirst)
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
              width: 100,
              height: 100,
            ),
            const Spacer(),
            if (Platform.isIOS)
              Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton(
                    onPressed: () async {
                      await context.read<LoginVM>().signInWithApple();
                      pushNext(context);
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
            if (Platform.isAndroid)
              Container(
                  margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                  child: ElevatedButton(
                      onPressed: () async {
                        await context.read<LoginVM>().signInWithGoogle();
                        pushNext(context);
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
                            'assets/glogo.png',
                            width: 15,
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
