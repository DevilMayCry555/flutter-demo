import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http.dart';
import 'hook.dart';

Future<List> fetchData(int type, String identity) async {
  var res = await axios
      .get('/open', queryParameters: {'type': type, 'identity': identity});
  // print('lalala');
  return res.data['rows'];
}

Future deleteData(String uid) async {
  var res = await axios.delete('/open', queryParameters: {'uid': uid});
  // print('lalala');
  return res;
}

Future updateData(String uid) async {
  var res = await axios.put('/open', queryParameters: {'uid': uid});
  // print('lalala');
  return res;
}

class ListMainPage extends StatelessWidget {
  const ListMainPage({
    super.key,
    required this.title,
    required this.type,
    required this.setType,
  });

  final String title;
  final int type;
  final Function(int) setType;

  void refresh() {
    setType(type - 1);
  }

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
      if (element['perfect_time'] == null) {
        list.add(element);
      }
    }
    return ListView.separated(
      itemCount: list.length,
      itemBuilder: (context, i) {
        Map item = list[i];
        String n = item['points'];
        return ListTile(
          leading: const Icon(Icons.question_mark_rounded),
          title: Text('$n points'),
          subtitle: Text('${item['create_time']}'),
          trailing: const Icon(Icons.more),
          onTap: () =>
              _openModal(context, item['title'], item['content'], item['uid']),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }

  void _openModal(BuildContext parent, String title, String body, String uid) {
    void onDelete(BuildContext context) {
      deleteData(uid)
          .then((value) => showEntry(parent, '删除成功'))
          .then((value) => refresh());
      Navigator.pop(context, 'onDelete');
    }

    void onFinish(BuildContext context) {
      updateData(uid)
          .then((value) => showEntry(parent, '任务达成'))
          .then((value) => refresh());
      Navigator.pop(context, 'onFinish');
    }

    showDialog<String>(
      context: parent,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(body),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => onDelete(context),
            child: const Text('Delete'),
          ),
          TextButton(
            onPressed: () => onFinish(context),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}
