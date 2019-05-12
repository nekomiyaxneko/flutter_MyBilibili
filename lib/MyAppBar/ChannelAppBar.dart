import 'package:flutter/material.dart';
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
          icon: Icon(Icons.search,color: Colors.white,),
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