import 'package:flutter/material.dart';

class MyFade extends StatefulWidget {
  const MyFade({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyFade> createState() => _MyFadeTest();
}

/// 动画
/// with 关键字用于混入(mixin)，它允许将其它类的功能添加到另一个类中，从而实现多继承
/// 这段声明说明，_MyFadeTest 可以访问 TickerProviderStateMixin 中的方法和属性
class _MyFadeTest extends State<MyFade> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    /// 初始化AnimationController实例 → 控制动画的执行过程，包括：开始、停止、暂停、反向播放
    controller = AnimationController(
      /// 动画执行时长
      duration: const Duration(milliseconds: 2000),

      /// 垂直同步信号，用于同步屏幕刷新和动画更新，避免出现屏幕闪烁、撕裂等问题。
      /// 这里的this → TickerProviderStateMixin
      /// 这个Tiker除了在垂直同步时发出信号，还在运行时创建一个介于0-1间的线性差值。
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        /// 过渡动画组件，用于实现透明度渐变动画
        child: FadeTransition(
          opacity: controller, // 子控件透明度
          child: const FlutterLogo(
            size: 100,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'Fade',
        tooltip: 'Fade',
        onPressed: () {
          controller.forward(); // 按钮按下时开始执行动画
        },
        child: const Icon(Icons.brush),
      ),
    );
  }
}
