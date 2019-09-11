import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/me/LoginPage.dart';

class DynamicPage extends StatefulWidget {
  @override
  _DynamicPageState createState() => _DynamicPageState();
}
class _DynamicPageState extends State<DynamicPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: (){
          Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new LoginPage()));
        },
        child: Container(
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/dynamic_login_guide.png"),fit: BoxFit.fitWidth)
          ),
        ),
      ), 
    );
  }
}