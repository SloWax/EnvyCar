import 'package:envy_car/Presentation/Car/AddCar/AddCarVM.dart';
import 'package:envy_car/Presentation/Car/CarInfo/CarInfoVM.dart';
import 'package:envy_car/Presentation/Car/Intro/IntroVM.dart';
import 'package:envy_car/Presentation/Car/Intro/IntroView.dart';
import 'package:envy_car/Presentation/Car/MaintenanceArticle/MaintenanceArticleVM.dart';
import 'package:envy_car/Presentation/Login/LoginVM.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => IntroVM()),
      ChangeNotifierProvider(create: (context) => LoginVM()),
      ChangeNotifierProvider(create: (context) => AddCarVM()),
      ChangeNotifierProvider(create: (context) => CarInfoVM()),
      ChangeNotifierProvider(create: (context) => MaintenanceArticleVM()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '오일갈쟈',
        theme: ThemeData(
            brightness: Brightness.dark,
            colorSchemeSeed: Colors.blueGrey,
            useMaterial3: true,
            textTheme: const TextTheme(
                bodyMedium:
                    TextStyle(fontSize: 32, fontStyle: FontStyle.italic))),
        home: const IntroView());
  }
}
