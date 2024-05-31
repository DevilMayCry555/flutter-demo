import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http.dart';

Future fetchData() async {
  var ipfig = await geo.get(
    '/ip',
    queryParameters: {
      'key': '382ac00b0f966675fb9d96027c61811c',
    },
  );
  if (ipfig.data['adcode'] is! String) {
    return {'ip': ipfig.data};
  }
  var weather = await geo.get(
    '/weather/weatherInfo',
    queryParameters: {
      'key': '382ac00b0f966675fb9d96027c61811c',
      'city': ipfig.data['adcode'],
    },
  );
  return {'ip': ipfig.data, 'weather': weather.data};
}

class WeatherPage extends StatelessWidget {
  const WeatherPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          // 这两个状态很少发生，一般只走 waiting 和 done
          // FutureBuilder 构建时如果指定了future，会立即开始等待future的执行，通常直接进入 waiting状态 而不会走 none状态
          // active状态 只能用于具有中间值的 StreamBuilder
          case ConnectionState.none:
          case ConnectionState.active:
            return Container();
          // 异步任务执行中，但未完成，这个时候适合显示Loading
          case ConnectionState.waiting:
            return const Center(
              child: Text('loading...'),
            );
          // 异步任务执行完毕，可能是执行成功，也可能是执行失败，需要做具体判断
          case ConnectionState.done:
            if (snapshot.hasError) {
              if (snapshot.error is DioException &&
                  (snapshot.error as DioException).error is SocketException) {
                return const Center(
                  child: Text('disconnect'),
                );
              } else {
                return const Center(
                  child: Text('error'),
                );
              }
            } else if (snapshot.hasData) {
              Map infos = snapshot.data;
              var base = infos['ip'];
              var city = '${base['province']} ${base['city']}';
              return Scaffold(
                body: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(city),
                      Text(infos['weather']['lives'].toString())
                    ],
                  ),
                ),
              );
            } else {
              return const Center(
                child: Text('empty'),
              );
            }
        }
      },
    );
  }
}
