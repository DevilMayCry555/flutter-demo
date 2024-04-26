import 'package:flutter/material.dart';

class Signature extends StatefulWidget {
  const Signature({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<Signature> createState() => _SignatureState();
}

/// canvas
class _SignatureState extends State<Signature> {
  List<Offset?> _points = <Offset>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        /// 当用户触摸屏幕并拖动时触发，该回调会接收一个details参数，包含触摸事件的详细信息
        onPanUpdate: (details) {
          setState(() {
            /// RederBox对象表示组件在屏幕上的几何形状和位置信息
            RenderBox? referenceBox = context.findRenderObject() as RenderBox;

            /// 将全局坐标转换为局部坐标，以便在SignaturePainter中绘制
            Offset localPosition =
                referenceBox.globalToLocal(details.globalPosition);

            /// 存储用户绘制的点
            _points = List.from(_points)..add(localPosition);
          });
        },

        /// 用户松开手指时触发，将null添加到点列表中，表示绘制结束。
        onPanEnd: (details) => _points.add(null),

        /// 使用 CustomPaint 组件来绘制签名，传入自定义的Painter
        /// 并设置组件的大小为无限大，即占满整个屏幕
        child: CustomPaint(
          painter: SignaturePainter(_points),
          size: Size.infinite,
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'Back',
            onPressed: () => Navigator.of(context).pop(),
            tooltip: 'Back',
            child: const Icon(Icons.arrow_back),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class SignaturePainter extends CustomPainter {
  SignaturePainter(this.points);
  final List<Offset?> points;
  @override
  void paint(Canvas canvas, Size size) {
    // 创建Paint对象，设置绘制签名时所需的样式和属性
    var paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5;

    /// 遍历点列表，当前点和下一个点都不为Null，绘制从当前点到下个点的线段
    for (int i = 0; i < points.length - 1; i++) {
      if (points[i] != null && points[i + 1] != null) {
        canvas.drawLine(points[i]!, points[i + 1]!, paint);
      }
    }
  }

  /// 判断是否需要重新绘制签名，新旧点数组比较
  @override
  bool shouldRepaint(SignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
