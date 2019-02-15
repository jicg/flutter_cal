import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {

  static const int NUM_BTN_BG=0xff323232;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("小鸡计算器"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(child:Column(children: <Widget>[
          Expanded(child: Center(child: Text("显示区域"))),
          Container(child: Center(child:Row(children: <Widget>[
            buildFlatButton(),buildFlatButton(flex: 2)
          ],)))
        ],)),
      ),
    );
  }

  Widget buildFlatButton({int flex = 1}) {
    return Expanded(
      flex: flex,
      child: FlatButton(
            onPressed: ()=>{},
            child: Container(
              decoration: BoxDecoration(
                color: Color(NUM_BTN_BG),
                shape: flex>1?BoxShape.rectangle:BoxShape.circle,
                borderRadius:flex>1? BorderRadius.all(Radius.circular(1000.0)):null
              ),
              padding:EdgeInsets.all(20.0),
              child: Center(child: Text("1",style: TextStyle(fontSize: 28.0,color: Colors.white),)),
            ),
          ),
    );
  }
}
