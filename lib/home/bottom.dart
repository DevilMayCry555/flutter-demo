import 'package:flutter/material.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget(
      {super.key, required this.onTap, required this.position});
  final Function(int) onTap;
  final int position;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        // setState(() => _position = position);
        onTap(value);
      },
      selectedItemColor: Colors.blue, // 选中时的颜色
      unselectedItemColor: Colors.black, // 未选中时的颜色
      showSelectedLabels: true, // 选中的label是否展示
      showUnselectedLabels: true, // 未选中的label是否展示
      // currentIndex: _position,
      currentIndex: position,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.article), label: '待办'),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: '历史'),
        BottomNavigationBarItem(icon: Icon(Icons.add_box), label: '发布'),
        BottomNavigationBarItem(icon: Icon(Icons.apple), label: '兑换'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '我的'),
      ],
    );
  }
}
