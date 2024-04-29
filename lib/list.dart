import 'package:flutter/material.dart';

import 'http.dart';

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key, required this.title});

  final String title;

  @override
  State<StatefulWidget> createState() => _SampleAppPageState();
}

/// 列表
class _SampleAppPageState extends State<SampleAppPage> {
  List _list = [];
  var loading = false;

  Future<void> fetchData() async {
    setState(() {
      loading = true;
    });
    var res = await axios.get('/posts');
    setState(() {
      _list = res.data;
      loading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: loading
          ? const Center(
              child: Text('loading...'),
            )
          : ListView(children: _getList(context)),
      // 惰性加载
      // : ListView.builder(
      //     itemCount: _list.length,
      //     itemBuilder: (context, i) {
      //       return GestureDetector(
      //         onTap: () => _openModal(context, i),
      //         child: Padding(
      //           padding: const EdgeInsets.all(10),
      //           child: Text('Row $i'),
      //         ),
      //       );
      //     },
      //   ),
    );
  }

  List<Widget> _getList(parent) {
    List<Widget> widgets = [];
    for (int i = 0; i < _list.length; i++) {
      Map item = _list[i];
      widgets.add(GestureDetector(
        onTap: () => _openModal(parent, item['title'], item['body']),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Row $i'),
        ),
      ));
    }
    return widgets;
  }

  void _openModal(parent, String title, String body) {
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
}
