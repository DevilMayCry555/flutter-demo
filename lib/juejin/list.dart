import 'package:flutter/material.dart';

import '../http.dart';

class JueJinMainPage extends StatelessWidget {
  const JueJinMainPage({super.key, required this.title});

  final String title;

  void handleTap(BuildContext context, int id) {
    axios.get('/posts/$id').then((value) => {
          Navigator.push(context, detail(value.data)),
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, i) {
        return GestureDetector(
          onTap: () => handleTap(context, i),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Row ${i + 1}'),
          ),
        );
      },
    );
  }

  MaterialPageRoute detail(Map info) {
    return MaterialPageRoute(builder: (context) {
      return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Card(
          child: GridTile(
            header: GridTileBar(
              title: Text(info['title']),
              subtitle: Text(info['id'].toString()),
            ),
            footer: Text(info['userId'].toString()),
            child: Text(info['body']),
          ),
          // child: Text(info.toString()),
        ),
      );
    });
  }
}
