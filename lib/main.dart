import 'package:dustcheckapp/bloc/air_bloc.dart';
import 'package:dustcheckapp/main2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() {
  runApp(MyApp());
}

final airBloc = AirBloc();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '오늘의 미세먼지',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AnimatedSplashScreen(
        splashIconSize: 1000.0,
        splash: Image.asset("assets/images/logo3.png"),
        nextScreen: Main2(),
        splashTransition: SplashTransition.fadeTransition,
        duration: 3000,
      ),
    );
  }
}
