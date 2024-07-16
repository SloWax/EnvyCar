import 'package:envy_car/View/AddCar/AddCarView.dart';
import 'package:envy_car/View/CarInfo/CarInfoView.dart';
import 'package:envy_car/View/Login/LoginView.dart';
import 'package:envy_car/View/MaintenanceArticle/MaintenanceArticleView.dart';
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
            textTheme: const TextTheme(
                //     titleLarge: TextStyle(fontSize: 12),
                bodyMedium:
                    TextStyle(fontSize: 32, fontStyle: FontStyle.italic))),
        // home: const LoginView());
        // home: const AddCarView());
        // home: const CarInfoView());
        home: const MaintenanceArticleView());
  }
}
