import 'package:flutter/material.dart';
class DynamicsAppBar extends StatefulWidget implements PreferredSizeWidget{
  final double height;
  const DynamicsAppBar({
    this.height:46.0,
  });
   @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
  @override
  _DynamicsAppBarState createState() => _DynamicsAppBarState();
}

class _DynamicsAppBarState extends State<DynamicsAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text("动态"),
      actions: <Widget>[
        IconButton(
          icon: Icon(IconData(0xe61e, fontFamily: "Bilibili")),
          onPressed: () {
            Scaffold.of(context).showSnackBar(new SnackBar(
              content: Text("请先登陆"),
            ));
          },
        ),
      ],
    );
  }
}