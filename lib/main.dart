import 'package:flutter/material.dart';
import 'package:clock/splash.dart';

void main() => runApp(new MaterialApp(
  theme:
  ThemeData(
      primaryColor:Color.fromARGB(255, 26, 115, 233),
      accentColor: Color.fromARGB(255, 234, 72, 58)),
  debugShowCheckedModeBanner: false,
  home: SplashScreen(),
));
