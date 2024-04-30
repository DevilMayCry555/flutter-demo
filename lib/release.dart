import 'package:flutter/material.dart';

List<String> tabStrList = [
  '衣',
  '食',
  '住',
  '行',
  '情绪',
  '工作',
  '护肤',
  '游戏',
  '生理',
  '家庭'
];

// 中间的内容面板
class ReleaseWidget extends StatefulWidget {
  const ReleaseWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ReleaseWidgetState();
}

class _ReleaseWidgetState extends State<ReleaseWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [],
    );
  }
}
  // List<Widget> _getList(parent) {
  //   List<Widget> widgets = [];
  //   for (int i = 0; i < _list.length; i++) {
  //     Map item = _list[i];
  //     widgets.add(GestureDetector(
  //       onTap: () =>
  //           _openModal(parent, item['username'], item['birthday'].toString()),
  //       child: Padding(
  //         padding: const EdgeInsets.all(10),
  //         child: Text('Row $i'),
  //       ),
  //     ));
  //   }
  //   return widgets;
  // }