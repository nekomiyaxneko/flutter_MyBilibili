import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:mytest/pages/MyHomePage.dart';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 12.0,right: 15.0),
                child: Image.asset("images/head_icon.jpg"),
                width: 70.0,
                height: 70.0,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("LLLinux",style: TextStyle(fontSize: 18.0,color: Colors.black),),
                    Text("wx_1234",style: TextStyle(fontSize: 14.0,color: Colors.grey),),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 12.0,right: 15.0),
                child: Image.asset("images/QR.png"),
                width: 20.0,
                height: 20.0,
              )
            ],
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("设置"),
            trailing:Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text("钱包"),
            trailing:Icon(Icons.arrow_forward),
          ),
          ListTile(
            leading: Icon(Icons.wb_cloudy),
            title: Text("云端"),
            trailing:Icon(Icons.arrow_forward),
          ),
        ],
      ),
    );
  }
}