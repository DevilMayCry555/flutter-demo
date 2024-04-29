import 'package:flutter/material.dart';

class JueJinMainPage extends StatelessWidget {
  const JueJinMainPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (context, i) {
        return ListTile(
          leading: const Text('leading'),
          title: Text('Row ${i + 1}'),
          subtitle: const Text('subtitle'),
          trailing: const Icon(Icons.more),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}
