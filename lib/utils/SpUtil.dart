//单利模式采用双重检验锁 但是 flutter 是单'线程'模式  所以多此一举

import 'package:shared_preferences/shared_preferences.dart';


class SpUtil {
  static SpUtil _singleton;
  static SharedPreferences _prefs;
 // static Lock _lock = Lock();

  static Future<SpUtil> getInstance() async {
    if (_singleton == null) {
    //  await _lock.synchronized(() async {
    //    if (_singleton == null) {
          // keep local instance till it is fully initialized.
          // 保持本地实例直到完全初始化。
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
    //    }
    //  }
    //);
    }
    return _singleton;
  }

  SpUtil._();

  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  //由于单线程  所以写操作没必要采用锁同步阻塞
  static saveData<T>(String key,T value) async{
    switch(T){
      case String:
        _prefs.setString(key, value as String);
        break;
      case int:
        _prefs.setInt(key, value as int);
        break;
      case bool:
        _prefs.setBool(key, value as bool);
        break;
      case double:
        _prefs.setDouble(key, value as double);
        break;

    }
  }
  //读取也是一样
  static Future<T> getData<T>(String key) async{
    T res;
    switch(T){
      case String:
        res = _prefs.getString(key) as T;
        break;
      case int:
        res = _prefs.getInt(key) as T;
        break;
      case bool:
        res = _prefs.getBool(key) as T;
        break;
      case double:
        res = _prefs.getDouble(key) as T;
        break;
    }
    return res;
  }
}
