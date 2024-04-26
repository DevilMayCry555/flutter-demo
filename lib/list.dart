import 'package:flutter/material.dart';

import 'http.dart';

class SampleAppPage extends StatefulWidget {
  const SampleAppPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<SampleAppPage> createState() => _SampleAppPageState();
}

/// 列表
class _SampleAppPageState extends State<SampleAppPage> {
  List _list = [];
  var loading = false;

  Future<void> _fetchData() async {
    setState(() {
      loading = true;
    });
    await loadData().then((value) => {
          setState(() {
            _list = value;
            loading = false;
          })
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
      floatingActionButton: FloatingActionButton(
        heroTag: 'Async',
        tooltip: 'fetch',
        onPressed: _fetchData,
        child: const Icon(Icons.brush),
      ),
    );
  }

  List<Widget> _getList(contextParent) {
    List<Widget> widgets = [];
    for (int i = 0; i < _list.length; i++) {
      Map item = _list[i];
      widgets.add(GestureDetector(
        onTap: () => showDialog<String>(
          context: contextParent,
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
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text('Row $i'),
        ),
      ));
    }
    return widgets;
  }
}
