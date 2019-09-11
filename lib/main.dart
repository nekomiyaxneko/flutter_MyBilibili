import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/SplashPage.dart';
void main() {
  runApp(MyApp());
  //以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值
  //SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  //SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
} 


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyBilibili',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor:Colors.pink[300],
      ),
      home: SplashPage(),

    );
  }
}




//选项卡的类目
