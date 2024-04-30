import 'package:flutter/material.dart';

import 'bottom.dart';
import 'search.dart';
import 'tab.dart';

class JueJinPage extends StatefulWidget {
  const JueJinPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _JueJinPageState();
}

class _JueJinPageState extends State<JueJinPage> {
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
            SearchBarWidget(),
            ContentWidget(),
          ], // 实例化这个搜索栏Widget
        ),
      ),
      bottomNavigationBar: const BottomBarWidget(),
    );
  }
}
