import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../http.dart';

class JueJinMainPage extends StatelessWidget {
  const JueJinMainPage({super.key, required this.title, required this.tid});

  final String title;
  final int tid;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchData(tid),
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
              return _getList(context, snapshot.data);
            } else {
              return const Center(
                child: Text('empty'),
              );
            }
        }
      },
    );
  }

  ListView _getList(BuildContext parent, List rows) {
    return ListView.separated(
      itemCount: rows.length,
      itemBuilder: (context, i) {
        Map item = rows[i];
        return ListTile(
          leading: Text(item['username']),
          title: Text('$title ${i + 1}'),
          subtitle: Text(item['birthday']),
          trailing: const Icon(Icons.more),
          onTap: () => _openModal(context, item['username'], item['birthday']),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}

Future<List> fetchData(int type) async {
  var res = await axios.get('/open?route=task&type=$type');
  return res.data['rows'];
}

void _openModal(BuildContext parent, String title, String body) {
  showDialog<String>(
    context: parent,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
