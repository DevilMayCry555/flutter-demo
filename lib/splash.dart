// splash_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    /// 初始化AnimationController实例 → 控制动画的执行过程，包括：开始、停止、暂停、反向播放
    controller = AnimationController(
      /// 动画执行时长
      duration: const Duration(milliseconds: 2500),

      /// 垂直同步信号，用于同步屏幕刷新和动画更新，避免出现屏幕闪烁、撕裂等问题。
      /// 这里的this → TickerProviderStateMixin
      /// 这个Tiker除了在垂直同步时发出信号，还在运行时创建一个介于0-1间的线性差值。
      vsync: this,
    );
    controller.forward();
    // 定义显示SplashScreen一段时间之后的逻辑
    Timer(const Duration(seconds: 3), () {
      // Replace it with a function to navigate to your home screen
      // 如：Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen()));
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: controller, // 子控件透明度
          child: const FlutterLogo(
            size: 100,
          ),
        ),
      ),
    );
  }
}
