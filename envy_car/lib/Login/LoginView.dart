import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  // final String data;

  // const SettingScreen(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: Text('로그인 없이 시작'))],
      ),
      body: SafeArea(
          child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
            const Spacer(),
            // Container(
            // alignment: Alignment.center,
            // child:
            const Text('Login', textAlign: TextAlign.center),
            // ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: ElevatedButton(
                  child: const Text('apple', style: TextStyle(fontSize: 24)),
                  onPressed: () {
                    print('apple');
                  }),
            ),
            const SizedBox(height: 10),
            Container(
                margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: ElevatedButton(
                    child: const Text('google', style: TextStyle(fontSize: 24)),
                    onPressed: () {
                      print('google');
                    })),
            const SizedBox(height: 15),
          ]))),
    );
  }
}
