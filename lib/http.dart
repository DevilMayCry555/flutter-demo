// import 'dart:convert';
// import 'dart:io';

import 'package:dio/dio.dart';
// import 'package:http/http.dart' as http;
// https://jsonplaceholder.typicode.com
// /posts	100 posts
// /comments	500 comments
// /albums	100 albums
// /photos	5000 photos
// /todos	200 todos
// /users	10 users

Dio init(String base) {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: base,
      connectTimeout: const Duration(seconds: 30), // 请求超时
      receiveTimeout: const Duration(seconds: 30), // 响应超时
      // 自定义请求头，ua不设置默认是：Dart/3.2 (dart:io)
      headers: {},
    ),
  );
  // 初始化拦截器
  dio.interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
    // 在请求发起前做一些事情
    return handler.next(option);
  }, onResponse: (response, handler) {
    // 在返回响应数据前做一些预处理
    return handler.next(response);
  }, onError: (error, handler) {
    // 请求失败时做一些预处理
    return handler.next(error);
  }));
  return dio;
}

Dio axios = init('https://tydwin.top/api');
Dio geo = init('https://restapi.amap.com/v3');

// 异步等待请求加载完毕，注意async和await关键字的位置
// Future<List> loadData() async {
//   var dataURL = Uri.parse('https://jsonplaceholder.typicode.com/posts');
//   http.Response response = await http.get(dataURL);
//   return jsonDecode(response.body);
// }
