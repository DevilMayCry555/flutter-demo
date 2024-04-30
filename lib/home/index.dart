import 'package:flutter/material.dart';

import 'bottom.dart';
import 'tab.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Container(
        color: Colors.white,
        child: const Column(
          children: [
            ContentWidget(),
          ], // 实例化这个搜索栏Widget
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(),
      drawer: Drawer(
        child: _leftDrawer(context),
      ),
    );
  }
}

ListView _leftDrawer(BuildContext context) {
  List<ListTile> links = [
    ListTile(
      leading: const Icon(Icons.score),
      title: const Text('Counter'),
      onTap: () => {Navigator.of(context).pushNamed('/counter')},
    ),
    ListTile(
      leading: const Icon(Icons.settings),
      title: const Text('Canvas'),
      onTap: () => {Navigator.of(context).pushNamed('/canvas')},
    ),
  ];
  return ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      const DrawerHeader(
        decoration: BoxDecoration(
          color: Color(0xFF5A78EA),
        ),
        child: Text(
          "lalaland",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
      ),
      ...links,
      const ListTile(
        leading: Icon(Icons.logout),
        title: Text('退出登录'),
      ),
    ],
  );
}
