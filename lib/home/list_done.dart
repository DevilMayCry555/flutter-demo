import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http.dart';

Future<List> fetchData(int type, String identity) async {
  var res = await axios
      .get('/open', queryParameters: {'type': type, 'identity': identity});
  // print('lalala');
  return res.data['rows'];
}

class ListDonePage extends StatelessWidget {
  const ListDonePage({super.key, required this.title, required this.type});

  final String title;
  final int type;

  @override
  Widget build(BuildContext context) {
    String userkey = Provider.of<String>(context, listen: true);
    if (userkey == '') {
      return const Text('loading...');
    }
    return FutureBuilder(
      future: fetchData(type, userkey),
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
    List list = [];
    for (var element in rows) {
      if (element['perfect_time'] != null) {
        list.add(element);
      }
    }
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (context, i) {
        Map item = list[i];
        return ListTile(
          leading: const Icon(Icons.task_alt_rounded),
          title: Text(item['title']),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(item['create_time']),
              Text(item['perfect_time']),
            ],
          ),
          trailing: Text(item['points']),
          onTap: () => _openModal(context, item['title'], item['content']),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}

void _openModal(BuildContext parent, String title, String body) {
  showDialog<String>(
    context: parent,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: Text(body),
      ),
      actions: <Widget>[
        // TextButton(
        //   onPressed: () => Navigator.pop(context, 'Cancel'),
        //   child: const Text('Cancel'),
        // ),
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
