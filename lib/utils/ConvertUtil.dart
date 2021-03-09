

import 'dart:convert';

class ConvertUtil {


  static  String list2Str(List<dynamic> list){
    String s = JsonEncoder().convert(list);
    return s;
  }

  static List str2List(String str){
    List list = [];
    for(var value in JsonDecoder().convert(str)){
      list.add(value);
    }
    return list;
  }

  static String set2Str(Set<dynamic> set){
    String s = JsonEncoder().convert(set);
    return s;
  }
  static Set str2Set(String str){
    Set set = {};
    for(var value in JsonDecoder().convert(str)){
      set.add(value);
    }
    return set;
  }

  static String map2Str(Map map){
    String str = json.encode(map);
    return str;
  }

  static Map str2Map(String str){
    Map map = json.decode(str);
    return map;
  }

}