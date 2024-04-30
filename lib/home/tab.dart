import 'package:flutter/material.dart';

import 'list.dart';

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
class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabStrList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          // const Text('lalala'),
          TabBar(
            isScrollable: true, // 设置可滚动
            controller: _tabController, // 关联TabController
            tabs: tabStrList.map((e) => Tab(text: e)).toList(),
          ),
          Expanded(
            child: TabBarView(
              // 同样使用TabBarView
              controller: _tabController, // 关联同一个TabController
              children: tabStrList
                  .map((e) => JueJinMainPage(
                        title: e,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}