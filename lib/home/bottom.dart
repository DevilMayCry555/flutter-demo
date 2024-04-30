import 'package:flutter/material.dart';

class BottomBarWidget extends StatefulWidget {
  const BottomBarWidget(
      {super.key, required this.onTap, required this.position});
  final Function(int) onTap;
  final int position;

  @override
  State<StatefulWidget> createState() => _BottomBarWidgetState();
}

class _BottomBarWidgetState extends State<BottomBarWidget> {
  // int _position = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (position) {
        // setState(() => _position = position);
        widget.onTap(position);
      },
      selectedItemColor: Colors.blue, // 选中时的颜色
      unselectedItemColor: Colors.black, // 未选中时的颜色
      showSelectedLabels: true, // 选中的label是否展示
      showUnselectedLabels: true, // 未选中的label是否展示
      // currentIndex: _position,
      currentIndex: widget.position,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: '待办'),
        BottomNavigationBarItem(icon: Icon(Icons.whatshot), label: '历史'),
        BottomNavigationBarItem(icon: Icon(Icons.zoom_out), label: '发布'),
        BottomNavigationBarItem(icon: Icon(Icons.book), label: '兑换'),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: '我的'),
      ],
    );
  }
}
