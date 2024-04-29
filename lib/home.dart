import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _getRouter(context),
        ),
      ),
      drawer: Drawer(
        child: _leftDrawer(),
      ),
    );
  }
}

Map routes = {
  '/a': 'List',
  '/b': 'Canvas',
  '/c': 'Animate',
  '/d': 'Counter',
  '/e': 'JueJin',
};
List<Widget> _getRouter(parent) {
  List<Widget> widgets = [];
  for (var key in routes.keys) {
    String label = routes[key];
    widgets.add(TextButton(
      onPressed: () => Navigator.of(parent).pushNamed(key),
      child: Text(label),
    ));
  }
  return widgets;
}

ListView _leftDrawer() {
  return ListView(
    padding: EdgeInsets.zero,
    children: const <Widget>[
      DrawerHeader(
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
      ListTile(
        leading: Icon(Icons.score),
        title: Text('我的积分'),
      ),
      ListTile(
        leading: Icon(Icons.settings),
        title: Text('系统设置'),
      ),
      ListTile(
        leading: Icon(Icons.logout),
        title: Text('退出登录'),
      ),
    ],
  );
}
