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

  List<String> _keys = [];

//右侧按钮
  static const RKeys = ["/", "*", "-", "+"];

  static const EQ = "=";

  void addKey(String key) {
    if (TKeys.contains(key)) {
      switch (key) {
        case "C":
          _s1 = [];
          _s2 = [];
          _s3 = [];
          _curnum = "";
          _output = "";
          _keys = [];
          return;
        case "D":
          removeLastKey();
          return;
      }
    }
    String prekey = "";
    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }
    //1 +1 +2 +3
    //处理数字到 _s1
    if (NKeys.contains(key)) {
      if (_curnum.isEmpty && _s1.isEmpty) {
        _output = "";
      }
      _output += key;
      _curnum += key;
      _keys.add(key);
    } else {
      if (_curnum.isNotEmpty) {
        _s1.add(_curnum);
        _curnum = "";
      }
    }

    //处理符号
    if (RKeys.contains(key)) {
      if (_s1.length == 0) {
        String rs = result.toString();
        _output = rs;
        for (int i = 0; i < rs.length; i++) {
          _keys.add(rs.substring(i, i + 1));
        }
        _s1.add(rs);
      }
      if (RKeys.contains(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
      if (_s2.length == 0) {
        _s2.add(key);
      } else {
        // 当前运算符优先级 小于或等于 _s2最末尾的运算符的优先级，
        // 我需要将s2的运算符依次从末尾取出，放入_s1
        String lastkey = _s2[_s2.length - 1];
        if (RKeysMap[key] <= RKeysMap[lastkey]) {
          while (_s2.length > 0 &&
              RKeysMap[key] <= RKeysMap[_s2[_s2.length - 1]]) {
            _s1.add(_s2.removeLast());
          }
        }
        _s2.add(key);
      }
    }

    if (EQ == key && (_s1.length > 0 || _curnum.isNotEmpty) && prekey != EQ) {
      if (RKeys.contains(prekey)) {
        removeLastKey();
      }
      _keys.add(key);
      _output += key;
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
      _keys = [];
    }
  }

  void removeLastKey() {
    String prekey = "";
    if (_keys.length > 0) {
      prekey = _keys[_keys.length - 1];
    }
    print(_s1);
    print(_s2);
    if (RKeys.contains(prekey)) {

      String k1 = _s1[_s1.length - 1];
      if (RKeys.contains(k1)) {
        _s2.removeLast();
        for (int i = _s1.length - 1; i >= 0; i--) {
          String tk = _s1[i];
          if (RKeys.contains(tk)) {
            _s2.add(_s1.removeLast());
          } else {
            break;
          }
        }
      } else {
        _s2.removeLast();
      }
      _output = _output.substring(0, _output.length - 1);
      _keys.removeLast();
    } else if (_s1.length > 0 || _curnum.isNotEmpty) {
      if (_curnum.isNotEmpty) {
        _curnum = _curnum.substring(0, _curnum.length - 1);
      } else {
        String tk = _s1.removeLast();
        tk = tk.substring(0, tk.length - 1);
        if (tk.isNotEmpty) {
          _s1.add(tk);
        }
      }
      _output = _output.substring(0, _output.length - 1);
      _keys.removeLast();
    }
  }
}
