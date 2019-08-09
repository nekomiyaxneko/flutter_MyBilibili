import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytest/pages/LoginPage.dart';

class MyBangumi extends StatefulWidget {
  @override
  _MyBangumiState createState() => _MyBangumiState();
}

class _MyBangumiState extends State<MyBangumi> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      alignment: Alignment.topCenter,
      child :GestureDetector(
        onTap: (){
          Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new LoginPage()));
        },
        child: Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("images/bangumi_home_login_guide.png",),fit: BoxFit.fitWidth)
          ),
        ),
      )
    );
  }
}