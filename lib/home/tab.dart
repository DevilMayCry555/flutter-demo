import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http.dart';
import 'hook.dart';
import 'list.dart';

Future<List> fetchData(int type, String identity) async {
  var res = await axios.get(
    '/open',
    queryParameters: {'type': type, 'identity': identity},
  );
  // print('lalala');
  List list = [];
  for (var element in [...res.data['rows']]) {
    if (element['perfect_time'] == null) {
      list.add(element);
    }
  }
  return list;
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

// 中间的内容面板
class ContentWidget extends StatefulWidget {
  const ContentWidget({super.key});

  @override
  State<StatefulWidget> createState() => _ContentWidgetState();
}

class _ContentWidgetState extends State<ContentWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  void refresh() {
    setState(() {
      _tabController.index = _tabController.index * 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabStrList.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onDelete(String uid) {
      deleteData(uid).whenComplete(() => refresh());
      Navigator.pop(context, 'onDelete');
    }

    void onFinish(String uid) {
      updateData(uid).whenComplete(() => refresh());
      Navigator.pop(context, 'onFinish');
    }

    void onTap(Map record) {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: Text(record['title']),
          content: SingleChildScrollView(
            child: Text(record['content']),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => onDelete(record['uid']),
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () => onFinish(record['uid']),
              child: const Text('Finish'),
            ),
          ],
        ),
      );
    }

    String userkey = Provider.of<String>(context, listen: true);
    if (userkey == '') {
      return const Text('-- empty --');
    }
    return Expanded(
      child: Column(
        children: <Widget>[
          // const Text('lalala'),
          TabBar(
            isScrollable: true, // 设置可滚动
            controller: _tabController, // 关联TabController
            tabs: tabStrList.map((e) => Tab(text: e)).toList(),
          ),
          Expanded(
            child: TabBarView(
              // 同样使用TabBarView
              controller: _tabController, // 关联同一个TabController
              children: tabStrList
                  .map((e) => ListMainPage(
                        getFuture: () =>
                            fetchData(tabStrList.indexOf(e) + 1, userkey),
                        onTap: onTap,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
