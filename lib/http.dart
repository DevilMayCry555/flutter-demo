import 'dart:convert';

import 'package:http/http.dart' as http;

// 异步等待请求加载完毕，注意async和await关键字的位置
Future<List> loadData() async {
  var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
  http.Response response = await http.get(dataURL);
  return jsonDecode(response.body);
}
