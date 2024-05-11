import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../http.dart';

List<String> tabStrList = [
  '衣',
  '食',
  '住',
  '行',
  '身',
  '性',
];

Future postData(Map data) async {
  var res = await axios.post(
    '/open',
    data: data,
  );
  // print('lalala');
  return res;
}

class CustomTextField extends StatefulWidget {
  const CustomTextField({super.key});

  @override
  State<StatefulWidget> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // final FocusNode _focusNode = FocusNode();
  // late TextEditingController _controller;

  // @override
  // void initState() {
  //   super.initState();
  //   _controller = TextEditingController();
  // }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   _focusNode.dispose();
  //   super.dispose();
  // }

  List<double> data = [
    1,
    2,
    3,
    4,
    5,
    6,
  ];
  double _value = 1;
  String title = '';
  String content = '';
  String points = '';
  void onSend() {
    String userkey = Provider.of<String>(context, listen: false);
    postData({
      'title': title,
      'content': content,
      'points': int.parse(points),
      'identity': userkey,
      'type': _value,
    }).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            // controller: _controller,
            style: const TextStyle(color: Colors.blue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'title',
            ),
            // onEditingComplete: () {
            //   print('onEditingComplete');
            // },
            onChanged: (v) {
              // print('onChanged:' + v);
              setState(() => title = v);
            },
            // onSubmitted: (v) {
            //   FocusScope.of(context).requestFocus(_focusNode);
            //   print('onSubmitted:' + v);
            //   _controller.clear();
            // },
          ),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.blue),
            minLines: 5,
            maxLines: 5,
            showCursor: true,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.all(10),
              hintText: "请输入...",
              border: OutlineInputBorder(),
              labelText: 'content',
            ),
            onChanged: (v) {
              // print('onChanged:' + v);
              setState(() => content = v);
            },
          ),
          const SizedBox(height: 16),
          const Text('类别：'),
          Wrap(
            children: data
                .map((e) => SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Radio<double>(
                            activeColor: Colors.orangeAccent,
                            value: e,
                            groupValue: _value,
                            onChanged: (v) => setState(() => _value = v ?? 0),
                          ),
                          Text(tabStrList[e.toInt() - 1]),
                        ],
                      ),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            // controller: _controller,
            style: const TextStyle(color: Colors.blue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'points',
            ),
            maxLength: 4,
            // onEditingComplete: () {
            //   print('onEditingComplete');
            // },
            onChanged: (v) {
              // print('onChanged:' + v);
              setState(() => points = v);
            },
            // onSubmitted: (v) {
            //   FocusScope.of(context).requestFocus(_focusNode);
            //   print('onSubmitted:' + v);
            //   _controller.clear();
            // },
          ),
          RawMaterialButton(
            elevation: 2,
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: const TextStyle(color: Colors.white),
            onPressed: onSend,
            // onLongPress: () => print('onLongPress'),
            child: const Text('发布'),
          )
        ],
      ),
    );
  }
}
