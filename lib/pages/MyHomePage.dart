import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/MyAppBar/ChannelAppBar.dart';
import 'package:flutter_MyBilibili/MyAppBar/DynamicsAppBar.dart';
import 'package:flutter_MyBilibili/MyAppBar/HomeAppBar.dart';
import 'package:flutter_MyBilibili/MyAppBar/MallAppBar.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/pages/channel/ChannelPage.dart';
import 'package:flutter_MyBilibili/pages/dynamic/DynamicPage.dart';
import 'package:flutter_MyBilibili/pages/home/home_page.dart';
import 'package:flutter_MyBilibili/pages/me/LoginPage.dart';
import 'package:flutter_MyBilibili/pages/mall/MallPage.dart';
import 'package:flutter_MyBilibili/pages/me/setting_main.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';
import 'package:flutter_MyBilibili/tools/MyColors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static final homescaffoldkey = new GlobalKey<ScaffoldState>(); //key的用法
  DateTime _lastClick ; //最后一次按返回
  int _selectedIndex = 0;
  final _widgetOptionsAppBar = [
    HomeAppBar(homescaffoldkey: homescaffoldkey), //主页
    ChannelAppBar(), //第二页
    DynamicsAppBar(), //第三页
    MallAppBar() //第四页
  ];
  final _widgetOptionsItem = [
    HomePage(),
    ChannelPage(),
    DynamicPage(),
    MallPage()
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(_lastClick);
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _checkDoubleClick,
      child: Scaffold(
        key: homescaffoldkey,
        appBar: _widgetOptionsAppBar.elementAt(_selectedIndex),
        body: Center(
          child: IndexedStack(
              index: _selectedIndex, children: _widgetOptionsItem), //保存每个页面的状态
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(IconData(0xe661, fontFamily: "Bilibili")),
                activeIcon: Icon(IconData(0xe662, fontFamily: "Bilibili")),
                title: Text("首页")),
            BottomNavigationBarItem(
                icon: Icon(IconData(0xe664, fontFamily: "Bilibili")),
                activeIcon: Icon(IconData(0xe663, fontFamily: "Bilibili")),
                title: Text("频道")),
            BottomNavigationBarItem(
                icon: Icon(IconData(0xe666, fontFamily: "Bilibili")),
                activeIcon: Icon(IconData(0xe665, fontFamily: "Bilibili")),
                title: Text("动态")),
            BottomNavigationBarItem(icon: Icon(BIcon.shop), title: Text("会员购")),
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
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      //TODO:添加背景图片
                      image: DecorationImage(image:  AssetImage("images/me_tv_sign_out.png",),fit: BoxFit.contain,alignment: Alignment.bottomRight),
                    ),
                    accountName: new Text(
                      "未登陆",
                      style: TextStyle(fontSize: 17),
                    ), //用户名字
                    accountEmail: new Text(
                      "点击头像登陆",
                      style: TextStyle(color: Colors.grey[300]),
                    ), //用户硬币，b币信息
                    currentAccountPicture: GestureDetector(
                      child: new CircleAvatar(
                        backgroundImage:
                            AssetImage("images/bili_default_avatar.png"),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            new CupertinoPageRoute(
                                builder: (context) => new LoginPage()));
                      },
                    ),
                    otherAccountsPictures: <Widget>[
                      Icon(
                        IconData(0xe6d4, fontFamily: "Bilibili"),
                        color: Colors.white,
                        size: 20,
                      ),
                      Icon(
                        IconData(0xe690, fontFamily: "Bilibili"),
                        color: Colors.white,
                        size: 20,
                      ),
                    ],
                  ),
                  ListTile(
                    selected: true,
                    leading: Icon(IconData(0xe661, fontFamily: "Bilibili")),
                    title: Text("主页"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe67b, fontFamily: "Bilibili")),
                    title: Text("历史记录"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.cloud_download),
                    title: Text("离线缓存"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe673, fontFamily: "Bilibili")),
                    title: Text("我的收藏"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe6c1, fontFamily: "Bilibili")),
                    title: Text("稍后再看"),
                    onTap: () {},
                  ),
                  DrawLine.GreyLine(), //画线
                  ListTile(
                    leading: Icon(Icons.file_upload),
                    title: Text("投稿"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(Icons.lightbulb_outline),
                    title: Text("创作中心"),
                    onTap: () {},
                  ),
                  DrawLine.GreyLine(),
                  ListTile(
                    leading: Icon(Icons.live_tv),
                    title: Text("直播中心"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: Icon(IconData(0xe6bf, fontFamily: "Bilibili")),
                    title: Text("我的订单"),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            DrawLine.GreyLine(),
            Container(
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, //平均分配空间
                children: <Widget>[
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingMainPage()));
                    },
                    child:Row(
                      children: <Widget>[
                        Icon(
                          Icons.settings,
                          color: Colors.grey,
                        ),
                        Text(
                          "设置",
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.widgets, color: Colors.grey),
                      Text("主题"),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.brightness_2, color: Colors.grey),
                      Text("夜间"),
                    ],
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _checkDoubleClick() {
    print("_lastclick $_lastClick");
    print("now ${DateTime.now()}");
    if (_lastClick==null||DateTime.now().difference(_lastClick) >Duration(seconds: 1)) {
      _lastClick = DateTime.now();
      Fluttertoast.showToast(msg: "再按一次退出");
      return Future.value(false);
    }
    else{
      return Future.value(true);
    }
  }
}
