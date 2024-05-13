import 'package:flutter/material.dart';

import 'hook.dart';
import 'list_done.dart';

// 中间的内容面板
class ContentDoneWidget extends StatefulWidget {
  const ContentDoneWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentDoneWidget>
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
                  .map((e) => ListDonePage(
                        title: e,
                        type: tabStrList.indexOf(e) + 1,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
