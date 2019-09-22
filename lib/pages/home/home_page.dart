import 'package:flutter/material.dart';

import '70th_anniversary_page.dart';
import 'live_list_page.dart';
import 'RecommendPage.dart';
import 'bangumi_list_page.dart';
import 'cinema_list_page.dart';
import 'hot_list_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> tabs = [
    "直播",
    "推荐",
    "热门",
    "追番",
    "影视",
    "70周年",
  ];
  final List<Widget> tabViews = [
    LiveListViewPage(),
    RecommendPage(),
    HotListPage(),
    BangumiListPage(),
    CinemaListPage(),
    C70thAnniversaryPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: tabs.length,
      initialIndex: 1, //默认选中
      child: Scaffold(
        appBar: TabBar(
          indicatorSize: TabBarIndicatorSize.label,
          labelColor: Colors.pinkAccent,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.pinkAccent,
          isScrollable: true, //设置为可以滚动
          tabs: tabs.map((String title) {
            return new Container(
              height: 35,
              child: Tab(
                text: title,
              ),
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
