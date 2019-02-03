import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("小鸡计算器"),
        centerTitle: true,
      ),
      body: Container(
        child: Center(
          child: Text("你好世界"),
        ),
      ),
    );
  }
}
