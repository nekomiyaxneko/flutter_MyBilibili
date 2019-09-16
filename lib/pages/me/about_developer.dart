import 'package:flutter/material.dart';

class AboutDeveloper extends StatefulWidget {
  @override
  _AboutDeveloperState createState() => _AboutDeveloperState();
}

class _AboutDeveloperState extends State<AboutDeveloper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("关于开发者"),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            height: 100,
            child: Image.asset("images/head_icon.jpg"),
          ),
          Center(
            child: Text("nekomiyaxneko"),
          ),
        ],
      ),
      
    );
  }
}