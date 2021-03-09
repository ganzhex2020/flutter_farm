import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_farm/utils/SpUtil.dart';

import 'ui/page/MainPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();

  runApp(MyApp());
  // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
  SystemUiOverlayStyle systemUiOverlayStyle =
  SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);

}

class MyApp extends StatefulWidget{

  @override
  State<StatefulWidget> createState() => _MyAppState();
}
class _MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {

    return new MaterialApp(

        debugShowCheckedModeBanner: false, //去掉页面右上角的debug标识
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage()
    );
  }
}


