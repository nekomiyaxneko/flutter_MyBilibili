import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/home/SearchIndexPage.dart';
class ChannelAppBar extends StatefulWidget implements PreferredSizeWidget{
  final double height;
  const ChannelAppBar({
    this.height:46.0,
  });
   @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
  @override
  _ChannelAppBarState createState() => _ChannelAppBarState();
}

class _ChannelAppBarState extends State<ChannelAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text("频道"),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: Icon(IconData(0xe672,fontFamily: "Bilibili")),
          onPressed: (){
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: Text("下载暂未开放"),
              )
            ); 
          },
        ),
        IconButton(
          icon: Icon(IconData(0xe669,fontFamily: "Bilibili")),
          onPressed: (){
            Navigator.push(context, new CupertinoPageRoute(builder: (contex)=> new SearchIndexPage()));//改为侧滑切换动画
          },
        ),
      ],
    );
  }
}