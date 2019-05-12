import 'package:flutter/material.dart';
import 'package:mytest/pages/LoginPage.dart';

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
          Navigator.push(context, new MaterialPageRoute(builder: (contex)=> new LoginPage()));
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