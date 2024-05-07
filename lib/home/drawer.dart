import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyConsumer extends StatelessWidget {
  const MyConsumer({super.key, required this.parent});
  final BuildContext parent;

  @override
  Widget build(BuildContext context) {
    var links = <Widget>[
      ListTile(
        leading: const Icon(Icons.score),
        title: const Text('Counter'),
        onTap: () => {Navigator.of(parent).pushNamed('/counter')},
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('Canvas'),
        onTap: () => {Navigator.of(parent).pushNamed('/canvas')},
      ),
      ListTile(
        leading: const Icon(Icons.bubble_chart),
        title: const Text('Consumer'),
        onTap: () => {Navigator.of(parent).pushNamed('/consumer')},
      ),
    ];
    // 使用 Consumer 监听
    return Consumer<String>(
      builder: (context, data, child) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color(0xFF5A78EA),
                ),
                child: Text(
                  data,
                  style: const TextStyle(
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
          ),
        );
      },
    );
  }
}
