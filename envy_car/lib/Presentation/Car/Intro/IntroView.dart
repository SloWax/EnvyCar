import 'package:envy_car/Presentation/Car/CarInfo/CarInfoView.dart';
import 'package:envy_car/Presentation/Car/Intro/IntroVM.dart';
import 'package:envy_car/Presentation/Login/LoginView.dart';
import 'package:envy_car/Util/CarManager.dart';
import 'package:envy_car/Util/FirebaseManager.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class IntroView extends StatefulWidget {
  const IntroView({super.key});

  @override
  _IntroViewState createState() => _IntroViewState();
}

class _IntroViewState extends State<IntroView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _loadDataAndNavigate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _loadDataAndNavigate() async {
    _controller = AnimationController(vsync: this);

    // 필요한 데이터 로드
    final userEmail = await CarManager().loadToken();
    final bool isData;

    if (userEmail == 'user') {
      final data = await CarManager().loadUser(userEmail);
      isData = data != null;
    } else {
      await FirebaseManager().roadFirebase(userEmail);
      isData = true;
    }

    // 위치 정보 받아오기
    await Provider.of<IntroVM>(context, listen: false).getCurrentLocation();

    // 스플래시 화면을 2초 동안 보여주기
    await Future.delayed(const Duration(seconds: 3));

    _controller.stop();

    // 다음 화면으로 이동
    if (isData) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const CarInfoView()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginView(isFirst: true)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Lottie.asset(
        'assets/AnimationCar.json',
        width: 300,
        height: 300,
        controller: _controller,
        onLoaded: (composition) {
          _controller.duration = composition.duration;
          _controller.repeat();
        },
      )),
    );
  }
}
