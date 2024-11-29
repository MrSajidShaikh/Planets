import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planets/views/splashpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        debugShowMaterialGrid: false,
        title: 'Planets: Explore the Solar System',
        theme: ThemeData(
          primarySwatch: Colors.purple,
        ),
        home: const SplashScreen());
  }
}
