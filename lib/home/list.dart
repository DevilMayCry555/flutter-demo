import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ListMainPage extends StatelessWidget {
  const ListMainPage({
    super.key,
    required this.getFuture,
    required this.onTap,
  });

  final Function getFuture;
  final Function(Map record) onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getFuture(),
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
              List rows = snapshot.data;
              return ListView.separated(
                itemCount: rows.length,
                itemBuilder: (context, i) {
                  Map item = rows[i];
                  return ListTile(
                    leading: const Icon(Icons.question_mark_rounded),
                    title: Text(item['title']),
                    subtitle: Text(item['create_time']),
                    trailing: Text(item['points']),
                    onTap: () => onTap(item),
                  );
                },
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  height: 1,
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
