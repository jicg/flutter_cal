import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  static const Color PAGE_COLOR = Colors.black;

  // 按钮
  static const Color NUM_BTN_BG = Color(0xff323232);

  //顶部按钮
  static const Color TOP_BTN_BG = Color(0xFFa6a6a6);

  //右侧按钮
  static const Color RIGHT_BTN_BG = Color(0xFFff9500);

  static const NKeys = [
    "C", "D", "?", "/", //
    "9", "8", "7", "*", //,
    "6", "5", "4", "-", //
    "3", "2", "1", "+", //
    "", "0", ".", "=", //
  ];

//顶部按钮
  static const TKeys = [
    "C",
    "D",
    "?",
  ];

//右侧按钮
  static const RKeys = ["/", "*", "-", "+", "="];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PAGE_COLOR,
      appBar: AppBar(
        title: Text("小鸡计算器"),
        backgroundColor: PAGE_COLOR,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            child: Column(
          children: <Widget>[
            Expanded(child: Center(child: Text("显示区域"))),
            Container(child: Center(child: _buildBtns()))
          ],
        )),
      ),
    );
  }

  Widget buildFlatButton(String num, {int flex = 1}) {
    return Expanded(
      flex: flex,
      child: FlatButton(
        onPressed: () => {},
        child: Container(
          decoration: BoxDecoration(
              color: TKeys.contains(num)
                  ? TOP_BTN_BG
                  : RKeys.contains(num) ? RIGHT_BTN_BG : NUM_BTN_BG,
              shape: flex > 1 ? BoxShape.rectangle : BoxShape.circle,
              borderRadius:
                  flex > 1 ? BorderRadius.all(Radius.circular(1000.0)) : null),
          padding: EdgeInsets.all(20.0),
          child: Center(
              child: Text(
            "$num",
            style: TextStyle(fontSize: 28.0, color: Colors.white),
          )),
        ),
      ),
    );
  }

  Widget _buildBtns() {
    List<Widget> rows = [];

    List<Widget> btns = [];
    int flex =1;
    for (int i = 0; i < NKeys.length; i++) {
      String key = NKeys[i];
      if(key.isEmpty){
        flex++;
        continue;
      }else{
        Widget b = buildFlatButton(key,flex: flex);
        btns.add(b);
        flex=1;
      }

      if ((i + 1) % 4 == 0) {
        rows.add(Row(
          children: btns,
        ));
        btns = [];
      }
    }
    if (btns.length > 0) {
      rows.add(Row(
        children: btns,
      ));
      btns = [];
    }

    return Column(
      children: rows,
    );
  }
}
