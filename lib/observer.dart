import 'package:flutter/material.dart';

class MyObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state.toString() == 'inactive') {
      // 应用处于非活跃状态，不接受用户输入
    }
    if (state.toString() == 'paused') {
      // 应用当前不可见，无法响应用户输入，并运行在后台
    }
    if (state.toString() == 'resumed') {
      // 应用当前可见，响应用户输入
    }
    if (state.toString() == 'detached') {
      // 全部宿主view均已脱离
    }
  }
}
