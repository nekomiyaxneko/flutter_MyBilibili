import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/pages/me/about_developer.dart';

class SettingMainPage extends StatefulWidget {
  @override
  _SettingMainPageState createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("设置"),
      ),
      body: Container(
        color: Colors.grey[100],
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Container(
              color: Colors.white,
              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> new AboutDeveloper()));
                },
                title: Text("关于我"),
                trailing: Icon(BIcon.more),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SettingItem{
  String title;
  Function onTap;
  SettingItem(this.title,this.onTap);
}