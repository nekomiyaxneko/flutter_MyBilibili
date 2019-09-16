import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/beans/ItemView.dart';
import 'package:flutter_MyBilibili/pages/home/HotGridViewPage.dart';
import 'package:flutter_MyBilibili/pages/home/MyBangumiPage.dart';
import 'package:flutter_MyBilibili/pages/home/LiveListViewPage.dart';
import 'package:flutter_MyBilibili/pages/home/RecommendPage.dart';


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
    const HomeTabBarItemView(title:"影视",icon:Icons.directions_bus,id: 5),
    const HomeTabBarItemView(title:"70周年",icon:Icons.directions_bus,id: 6),
  ];
  final List<Widget> tabViews=[
    LiveListViewPage(),
    RecommendPage(),
    HotGridViewPage(),
    MyBangumi(),
    MyBangumi(),
    MyBangumi(),
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: items.length,
      initialIndex: 1,//默认选中
      child: Scaffold(
        appBar: TabBar(
            indicatorSize: TabBarIndicatorSize.label,
            labelColor: Colors.pinkAccent,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.pinkAccent,
            isScrollable: true,//设置为可以滚动
            tabs: items.map((HomeTabBarItemView item){
              return new Tab(
                text: item.title,
                //icon: Icon(item.icon,color: Colors.primaries[1],),
              );
            }).toList(),
          ),
        
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );  
  }
}