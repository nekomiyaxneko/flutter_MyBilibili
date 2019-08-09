import 'package:flutter/material.dart';
import 'package:mytest/pages/SearchIndexPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:mytest/pages/SecondPage.dart';

class HomeAppBar extends StatefulWidget implements PreferredSizeWidget{
  //final Image ic_head;
  final  GlobalKey<ScaffoldState> homescaffoldkey;
  final double height;
  const HomeAppBar({
    this.height:46.0,
    this.homescaffoldkey
  });
   @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
  @override
  _HomeAppBarState createState() => _HomeAppBarState(homescaffoldkey:homescaffoldkey);
  
}

class _HomeAppBarState extends State<HomeAppBar> {
  //final Image ic_head;
  _HomeAppBarState({
    this.homescaffoldkey
  });
  final GlobalKey<ScaffoldState> homescaffoldkey;
  void _opendrawer(){
    homescaffoldkey.currentState.openDrawer();
  }
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      leading: GestureDetector(
        child: Row(
          children: <Widget>[
            Icon(Icons.menu),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(17)),
                border: Border.all(width: 1,color: Colors.white),
                image: DecorationImage(image: AssetImage("images/bili_default_avatar.png"))
              ),
            ),
          ],
        ),
        onTap: (){
          _opendrawer();
        },
      ),
      title: GestureDetector(
        child: Opacity(
          opacity: 0.15,
          child: Container(
            //width: 170.0,
            height: 30,
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(Icons.search,color: Colors.white,),
            ),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20.0))
            ),
          ),
        ),
        onTap: (){
          print("点击了搜索");
          Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new SearchIndexPage()));//改为侧滑切换动画
        },
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.videogame_asset,color: Colors.white,),
          onPressed: (){
            Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new SecondPage()));
          },
        ),
        IconButton(
          icon: Icon(Icons.save_alt,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: Text("暂未开放"),
              )
            ); 
          },
        ),
        IconButton(
          icon: Icon(Icons.chat,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: Text("暂未开放"),
              )
            );
          },
        ),
      ],
    );
  }
}