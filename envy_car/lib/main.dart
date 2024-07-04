import 'package:envy_car/Car/AddCarView.dart';
import 'package:envy_car/Login/LoginView.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '오일갈쟈',
        theme: ThemeData(
          brightness: Brightness.dark,
          // appBarTheme: AppBarTheme(backgroundColor: Colors.redAccent),
          colorSchemeSeed: Colors.blueGrey,
          useMaterial3: true,
          // textTheme: const TextTheme(
          //     titleLarge: TextStyle(fontSize: 12),
          //     bodyMedium:
          //         TextStyle(fontSize: 32, fontStyle: FontStyle.italic))
        ),
        // home: LoginView());
        home: AddCarView());
  }
}
