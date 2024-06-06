import 'dart:async';

import 'package:flutter/material.dart';

// var show = false;
void showEntry(BuildContext context, String message) {
  // if (show) {
  //   return;
  // }
  var entry = OverlayEntry(
    builder: (context) => Center(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Text(message),
        ),
      ),
    ),
  );
  Overlay.of(context).insert(entry);
  // show = true;
  Timer(const Duration(seconds: 1), () {
    entry.remove();
    // show = false;
  });
}

List<String> tabStrList = [
  '臂',
  '胸',
  '腹',
  '腰',
  '臀',
  '腿',
];
