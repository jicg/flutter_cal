import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("小鸡计算器"),
        centerTitle: true,
      ),
      body: Container(child:Column(children: <Widget>[
        Expanded(child: Center(child: Text("显示区域"))),
        Container(height:300,color:Colors.blue,child: Center(child: Text("操作区域")))
      ],)),
    );
  }
}
