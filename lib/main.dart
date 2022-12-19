import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'view/homeScreen.dart';
import 'view/secondScreen.dart';

void main() {
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const HomeScreen(),
        '/second': (context) => const SecondScreen(),
      },
    ),
  );
}
