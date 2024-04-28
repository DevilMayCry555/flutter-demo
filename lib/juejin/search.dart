import 'package:flutter/material.dart';
// 顶部搜索栏

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // 添加内间距：水平16像素，垂直8像素
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: <Widget>[
            // 使用Expanded填满剩余控件
            Expanded(
              child: Container(
                // 设置下容器的内边距，不然图标和文本太挤了
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                // 设置圆角灰色背景
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F4F6), // 圆角背景色
                  borderRadius: BorderRadius.circular(8.0), // 圆角的大小
                ),
                // 搜索图标和搜索提示文本
                child: const Row(
                  children: [
                    Icon(Icons.search, color: Color(0xFF8C8D92)),
                    SizedBox(width: 8.0), // 图标和文本之间的间距
                    Text(
                      '搜索稀土掘金',
                      style: TextStyle(
                          fontSize: 14.0, // 字体大小
                          color: Color(0xFF8C8D92), // 设置字体颜色
                          decoration: TextDecoration.none, // 设置不显示下划线
                          fontWeight: FontWeight.normal), // 设置字体不要加粗
                    ),
                  ],
                ),
              ),
            ),
            // 在签到图标和搜索框间添加一点间距
            const SizedBox(width: 8.0),
            const Icon(Icons.assistant_photo)
          ],
        ));
  }
}
