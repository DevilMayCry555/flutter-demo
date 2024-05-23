import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';
import 'home/index.dart';
import 'signature.dart';
import 'splash.dart';
import 'webview.dart';

Future<String> fetchData() async {
  var identity = "human";
  return Future.delayed(const Duration(seconds: 2), () {
    // user_id
    return identity;
  });
}

// class CounterProvider extends ChangeNotifier {
//   var count = 0;
//   var key = 'tydly';
//   void increment() {
//     count++;
//     notifyListeners(); //通知更新
//   }
// }

void main() {
  // 全局状态管理 Provider
  runApp(FutureProvider<String>(
    create: (context) => fetchData(),
    initialData: '',
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
    var user = Provider.of<String>(context, listen: true);
    var loading = user == '';
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
      // home: const IndexPage(title: 'Home'),
      home: IndexedStack(
        index: loading ? 1 : 0,
        children: [
          const IndexPage(title: 'Home'),
          const SplashScreen(),
          MyWebview(identity: user)
        ],
      ),
      routes: <String, WidgetBuilder>{
        '/canvas': (context) => const Signature(),
        '/counter': (context) => const MyCounter(title: 'Counter'),
        // '/webview': (context) => MyWebview(identity: user)
      },
    );
  }
}
