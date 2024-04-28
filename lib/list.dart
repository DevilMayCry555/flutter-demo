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

  Future<void> _fetchData() async {
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'Async',
        tooltip: 'fetch',
        onPressed: _fetchData,
        child: const Icon(Icons.brush),
      ),
    );
  }

  List<Widget> _getList(parent) {
    List<Widget> widgets = [];
    for (int i = 0; i < _list.length; i++) {
      widgets.add(GestureDetector(
        onTap: () => _openModal(parent, i),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Row $i'),
        ),
      ));
    }
    return widgets;
  }

  void _openModal(parent, int index) {
    Map item = _list[index];
    showDialog<String>(
      context: parent,
      builder: (BuildContext context) => AlertDialog(
        title: Text(item['title']),
        content: Text(item['body']),
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
