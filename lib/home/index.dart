import 'package:flutter/material.dart';

import 'bottom.dart';
import 'send.dart';
import 'tab.dart';
import 'tab_done.dart';

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
    // String name = Provider.of<String>(context, listen: true);

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
            Column(children: [ContentDoneWidget()]),
            Column(children: [CustomTextField()]),
            Text('兑换...'),
            Text('我的...'),
          ],
        ),
      ),
      bottomNavigationBar: BottomBarWidget(
        onTap: _onTap,
        position: _position,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF5A78EA),
              ),
              child: Text(
                'HELLO WORLD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.score),
              title: const Text('Counter'),
              onTap: () => Navigator.of(context).pushNamed('/counter'),
            ),
            ListTile(
              leading: const Icon(Icons.draw),
              title: const Text('Canvas'),
              onTap: () => Navigator.of(context).pushNamed('/canvas'),
            ),
          ],
        ),
      ),
    );
  }
}
