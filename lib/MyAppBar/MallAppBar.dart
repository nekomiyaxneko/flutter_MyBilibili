import 'package:flutter/material.dart';
class MallAppBar extends StatefulWidget implements PreferredSizeWidget{
  final double height;
  const MallAppBar({
    this.height:46.0,
  });
   @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(height);
  @override
  _MallAppBarState createState() => _MallAppBarState();
}

class _MallAppBarState extends State<MallAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: Text("会员购"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.shopping_cart,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: Text("请先登陆"),
              )
            );
          },
        ),
        IconButton(
          icon: Icon(Icons.person,color: Colors.white,),
          onPressed: (){
            Scaffold.of(context).showSnackBar(
              new SnackBar(
                content: Text("请先登陆"),
              )
            ); 
          },
        ),
      ],
    );
  }
}