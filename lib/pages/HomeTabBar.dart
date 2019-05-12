import 'package:flutter/material.dart';
import 'package:mytest/beans/ItemView.dart';
import 'package:mytest/pages/HotGridViewPage.dart';
import 'package:mytest/pages/MyBangumiPage.dart';
import 'package:mytest/pages/SelectedView.dart';
import 'LiveListViewPage.dart';


class HomeTabBar extends StatefulWidget {
  @override
  _HomeTabBarState createState() => _HomeTabBarState();
}

class _HomeTabBarState extends State<HomeTabBar> {
  final List<HomeTabBarItemView> items=<HomeTabBarItemView>[
    const HomeTabBarItemView(title:"直播",icon:Icons.directions_car,id: 1),
    const HomeTabBarItemView(title:"推荐",icon:Icons.directions_bike,id: 2),
    const HomeTabBarItemView(title:"热门",icon:Icons.directions_railway,id: 3),
    const HomeTabBarItemView(title:"追番",icon:Icons.directions_bus,id: 4),
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: items.length,
      initialIndex: 1,//默认选中
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          centerTitle:true,
          backgroundColor: Colors.white,
          title:TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pinkAccent,
            //isScrollable: true,//设置为可以滚动
            tabs: items.map((HomeTabBarItemView item){
              return new Tab(
                text: item.title,
                //icon: Icon(item.icon,color: Colors.primaries[1],),
              );
            }).toList(),
          ),
        ),
        
        body: TabBarView(
          children: items.map((HomeTabBarItemView item){
            switch (item.id){
              case 1:{
                return new LiveListViewPage();
              }
              case 2:{
                return new HotGridViewPage(item:item);
              }
              case 3:{
                return new HotGridViewPage(item:item);
              }
              case 4:{
                return new MyBangumi();
              }
            }
              
              
          }).toList(),
        ),
      ),
    );  
  }
}