import 'package:flutter/material.dart';

class JueJinMainPage extends StatelessWidget {
  const JueJinMainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 100,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () => print(context),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Row $i'),
          ),
        );
      },
    );
  }
}
