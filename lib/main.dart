import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';
import 'home/index.dart';
import 'signature.dart';

Future<String> fetchData() async {
  return Future.delayed(const Duration(seconds: 3), () {
    return "Hello Admin!";
  });
}

void main() {
  // 全局状态管理 Provider
  runApp(FutureProvider<String>(
    create: (context) => fetchData(),
    initialData: '加载中',
    child: Consumer<String>(
      builder: (context, data, child) {
        return const MyApp();
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const IndexPage(title: 'Home'),
      routes: <String, WidgetBuilder>{
        '/canvas': (context) => const Signature(title: 'Canvas'),
        '/counter': (context) => const MyCounter(title: 'Counter'),
      },
    );
  }
}
