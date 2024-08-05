import 'package:envy_car/Presentation/Car/AddCar/AddCarView.dart';
import 'package:envy_car/Presentation/Login/LoginVM.dart';
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
            const Text('Login', textAlign: TextAlign.center),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                  child: const Text('apple', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    print('apple');
                    context.read<LoginVM>().signInWithApple();
                  }),
            ),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton(
                    child: const Text('google', style: TextStyle(fontSize: 24)),
                    onPressed: () {
                      print('google');
                      context.read<LoginVM>().signInWithGoogle();
                    })),
            const SizedBox(height: 15),
          ]))),
    );
  }
}
