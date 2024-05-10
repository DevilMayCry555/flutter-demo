import 'package:flutter/material.dart';

List<String> tabStrList = [
  '衣',
  '食',
  '住',
  '行',
  '身',
  '性',
];

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
            onEditingComplete: () {
              print('onEditingComplete');
            },
            onChanged: (v) {
              print('onChanged:' + v);
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
              print('onChanged:' + v);
            },
          ),
          const SizedBox(height: 16),
          const Text('类别：'),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data
                .map((e) => Row(
                      children: [
                        Radio<double>(
                          activeColor: Colors.orangeAccent,
                          value: e,
                          groupValue: _value,
                          onChanged: (v) => setState(() => _value = v ?? 0),
                        ),
                        Text(tabStrList[e.toInt() - 1]),
                      ],
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
          TextField(
            // controller: _controller,
            style: const TextStyle(color: Colors.blue),
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'point',
            ),
            maxLength: 4,
            onEditingComplete: () {
              print('onEditingComplete');
            },
            onChanged: (v) {
              print('onChanged:' + v);
            },
            // onSubmitted: (v) {
            //   FocusScope.of(context).requestFocus(_focusNode);
            //   print('onSubmitted:' + v);
            //   _controller.clear();
            // },
          ),
          const SizedBox(height: 16),
          RawMaterialButton(
            elevation: 2,
            fillColor: Colors.blue,
            splashColor: Colors.orange,
            textStyle: const TextStyle(color: Colors.white),
            onLongPress: () => print('onLongPress'),
            child: const Text('发布'),
            onPressed: () => print('onPressed'),
          )
        ],
      ),
    );
  }
}
