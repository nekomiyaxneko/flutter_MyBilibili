import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mytest/MyAppBar/ChannelAppBar.dart';
import 'package:mytest/MyAppBar/DynamicsAppBar.dart';
import 'package:mytest/MyAppBar/HomeAppBar.dart';
import 'package:mytest/MyAppBar/MallAppBar.dart';
import 'package:mytest/pages/ChannelPage.dart';
import 'package:mytest/pages/DynamicPage.dart';
import 'package:mytest/pages/HomeTabBar.dart';
import 'package:mytest/pages/LoginPage.dart';
import 'package:mytest/pages/MallPage.dart';
import 'package:mytest/pages/MePage.dart';
import 'package:mytest/tools/LineTools.dart';
import 'package:mytest/tools/MyColors.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final  homescaffoldkey = new GlobalKey<ScaffoldState>();//key的用法
  int _selectedIndex=0;
  final _widgetOptionsAppBar=[
    HomeAppBar(homescaffoldkey:homescaffoldkey),//主页
    ChannelAppBar(),//第二页
    DynamicsAppBar(),//第三页
    MallAppBar()//第四页
    ];
  final _widgetOptionsItem=[HomeTabBar(),ChannelPage(),DynamicPage(),MallPage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homescaffoldkey,
      appBar:  _widgetOptionsAppBar.elementAt(_selectedIndex),
      
      body: Center(
        child: IndexedStack(index: _selectedIndex, children: _widgetOptionsItem),//保存每个页面的状态
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title:Text("首页")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.color_lens),
            title:Text("频道")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title:Text("动态")
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            title:Text("会员购")
          ),
        ],
        currentIndex: _selectedIndex,
        fixedColor: MyColors.bilibili_main,
        onTap: _onItemTapped,
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(),
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: new Text("未登陆",style: TextStyle(fontSize: 17),),//用户名字
                    accountEmail: new Text("点击头像登陆",style: TextStyle(color: Colors.grey[300]),),//用户硬币，b币信息
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        backgroundImage: AssetImage("images/bili_default_avatar.png"),
                      ),
                      onTap: (){
                        Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new LoginPage()));
                      },
                    ),
                    otherAccountsPictures: <Widget>[
                      /*
                        Container(//钱包
                          child: Icon(Icons.input,color: Colors.white,size: 30,),
                        ),
                        */
                        Container(//扫二维码
                          child: Icon(Icons.crop_free,color: Colors.white,size: 30,),
                        ),
                    ],
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text("主页"),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.update),
                    title: Text("历史记录"),
                    onTap: (){
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud_download),
                    title: Text("离线缓存"),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: Icon(Icons.star),
                    title: Text("我的收藏"),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: Icon(Icons.ondemand_video),
                    title: Text("稍后再看"),
                    onTap: (){},
                  ),
                  DrawLine.GreyLine(),//画线
                  ListTile(
                    leading: new CircleAvatar(child: Icon(Icons.file_upload),backgroundColor: Colors.white,),
                    title: Text("投稿"),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: new CircleAvatar(child: Icon(Icons.lightbulb_outline),backgroundColor: Colors.white,),
                    title: Text("创作中心"),
                    onTap: (){},
                  ),
                  DrawLine.GreyLine(),
                  ListTile(
                    leading: new CircleAvatar(child: Icon(Icons.live_tv),backgroundColor: Colors.white,),
                    title: Text("直播中心"),
                    onTap: (){},
                  ),
                  ListTile(
                    leading: new CircleAvatar(child: Icon(Icons.playlist_add_check),backgroundColor: Colors.white,),
                    title: Text("我的订单"),
                    onTap: (){},
                  ),
                ],
              ),
            ),
            DrawLine.GreyLine(),
            Container(
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,//平均分配空间
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      CircleAvatar(child: Icon(Icons.settings),backgroundColor: Colors.white,),
                      Text("设置"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(child: Icon(Icons.widgets),backgroundColor: Colors.white,),
                      Text("主题"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      CircleAvatar(child: Icon(Icons.brightness_2),backgroundColor: Colors.white,),
                      Text("夜间"),
                    ],
                  ),

                ],
              ),
            )
          ],
        )
      ),
    );
  }
  void _onItemTapped(int index){
    setState(() {
     _selectedIndex=index; 
    });
  }
}