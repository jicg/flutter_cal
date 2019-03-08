class Cal {
  String _output = "";

  String _curnum = "";

  double result = 0.0;

  String get OutPut => this._output;

  List<String> _s1 = [], _s2 = [];
  List<double> _s3 = [];

  static const NKeys = [
    "9", "8", "7", //,
    "6", "5", "4", //
    "3", "2", "1", //
    "0", ".", //
  ];

//顶部按钮
  static const TKeys = [
    "C",
    "D",
    "?",
  ];

  static const RKeysMap = {"/": 2, "*": 2, "-": 1, "+": 1};

//右侧按钮
  static const RKeys = ["/", "*", "-", "+"];

  static const EQ = "=";

  void addKey(String key) {
    //1 +1 +2 +3
    //处理数字到 _s1
    if (NKeys.contains(key)) {
      _output += key;
      _curnum += key;
    } else {
      _s1.add(_curnum);
      _curnum = "";
      _output += key;
    }

    //处理符号
    if (RKeys.contains(key)) {
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        // 当前运算符优先级 小于或等于 _s2最末尾的运算符的优先级，
        // 我需要将s2的运算符依次从末尾取出，放入_s1
        String lastkey = _s2[_s2.length - 1];
        if (RKeysMap[key] <= RKeysMap[lastkey]) {
          while (_s2.length > 0) {
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }

    if (EQ == key) {
      while (_s2.length > 0) {
        _s1.add(_s2.removeLast());
      }
      // 1 1 + 2+ 3 + 4 +
      for (int i = 0; i < _s1.length; i++) {
        String k = _s1[i];
        if (!RKeys.contains(k)) {
          _s3.add(double.parse(k));
        } else {
          switch (k) {
            case "+":
              _s3.add(_s3.removeLast() + _s3.removeLast());
              break;
            case "*":
              _s3.add(_s3.removeLast() * _s3.removeLast());
              break;
            case "-":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 - r1);
              break;
            case "/":
              double r1 = _s3.removeLast(), r2 = _s3.removeLast();
              _s3.add(r2 / r1);
              break;
          }
        }
      }

      result = _s3[0];
      _output += "$result";
      _s3 = [];
      _s2 = [];
      _s1 = [];
    }
  }
}
