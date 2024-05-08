import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserInfo extends StatelessWidget {
  const UserInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // 使用 Consumer 监听
    return Consumer<String>(
      builder: (context, data, child) {
        return DrawerHeader(
          decoration: const BoxDecoration(
            color: Color(0xFF5A78EA),
          ),
          child: Text(
            data,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        );
      },
    );
  }
}
