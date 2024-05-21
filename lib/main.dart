import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counter.dart';
import 'home/index.dart';
import 'location.dart';
import 'signature.dart';
import 'splash.dart';

Future<String> fetchData() async {
  var identity = "tydly";
  await postLocation(identity);
  // return Future.delayed(const Duration(seconds: 3), () {
  //   // user_id
  //   return identity;
  // });
  return identity;
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
        return MyApp(
          identity: data,
        );
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.identity});
  // This widget is the root of your application.
  final String identity;

  @override
  Widget build(BuildContext context) {
    var loading = identity == '';
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
        children: const [IndexPage(title: 'Home'), SplashScreen()],
      ),
      routes: <String, WidgetBuilder>{
        '/canvas': (context) => const Signature(),
        '/counter': (context) => const MyCounter(title: 'Counter'),
      },
    );
  }
}
