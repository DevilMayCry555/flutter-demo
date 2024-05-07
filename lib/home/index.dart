import 'package:flutter/material.dart';

import 'bottom.dart';
import 'drawer.dart';
import 'tab.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  late PageController _pageController;

  int _position = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _position);
  }

  void _onTap(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  void _onPageChanged(int index) {
    // 页面改变时更新下标状态
    setState(() {
      _position = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Colors.white,
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: const [
            Column(children: [ContentWidget()]),
            Text('待办...'),
            Text('发布...'),
            Text('兑换...'),
            Text('我的...'),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        onTap: _onTap,
        position: _position,
      ),
      drawer: MyConsumer(parent: context),
    );
  }
}
