// splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // 定义显示SplashScreen一段时间之后的逻辑
    Timer(const Duration(seconds: 3), () {
      // Replace it with a function to navigate to your home screen
      // 如：Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const MyHomePage(title: 'Home Page')));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome to my App!', style: TextStyle(fontSize: 24.0)),
      ),
    );
  }
}
