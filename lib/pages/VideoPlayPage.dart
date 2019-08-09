import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mytest/model/VideoItem.dart';
import 'package:mytest/model/VideoItemFromJson.dart';
import 'package:mytest/pages/HomeTabBar.dart';
import 'package:mytest/pages/HotGridViewPage.dart';
import 'package:mytest/pages/ReviewsPage.dart';
import 'package:mytest/pages/video_detail_page.dart';
import 'package:mytest/tools/MyVideoPlayer.dart';
import 'package:mytest/util/GetUtilBilibili.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayPage extends StatefulWidget {
  @override
  final VideoItem videoitem; //视频基本信息，av号封面
  VideoPlayPage(this.videoitem);
  _VideoPlayPageState createState() =>
      _VideoPlayPageState(videoitem: videoitem);
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  var _videoplayscaffoldkey = new GlobalKey<ScaffoldState>(); //key的用法
  final VideoItem videoitem;
  VideoItemFromJson videoItemFromJson; //视频详细信息，介绍等
  TabController _tabController =
      TabController(length: 2, vsync: AnimatedListState());
  ScrollController _nestedScrollViewController = ScrollController();
  bool _getvideodetailisok = false;
  bool isclickcover = false;
  bool _isHideTitle = true;
  _VideoPlayPageState({this.videoitem});
  @override
  void initState() {
    // TODO: implement initState
    getDetail();
    //设置封面滚动监听，隐藏标题
    _nestedScrollViewController.addListener(() {
      print(_nestedScrollViewController.offset);
      if (_nestedScrollViewController.offset > 166 && _isHideTitle == true) {
        setState(() {
          _isHideTitle = false;
        });
      } else if (_nestedScrollViewController.offset <= 166 &&
          _isHideTitle == false) {
        setState(() {
          _isHideTitle = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _nestedScrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void getDetail() async {
    videoItemFromJson =
        await GetUtilBilibili.getVideoDetailByAid(videoitem.aid);
    if (videoItemFromJson != null) {
      _getvideodetailisok = true;
      print("getDetailok");
    }
    setState(() {});
  }

  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _videoplayscaffoldkey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _videoplayscaffoldkey,
      body: NestedScrollView(
        controller: _nestedScrollViewController,
        headerSliverBuilder: (context, i) {
          return <Widget>[
            SliverAppBar(
              title: Offstage(
                offstage: _isHideTitle,
                child: Text("立即播放"),
              ),
              elevation: 1,
              centerTitle: true,
              forceElevated: true,
              expandedHeight: 220,
              //floating: true,
              //snap: true,
              pinned: true,
              titleSpacing: NavigationToolbar.kMiddleSpacing,
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                background: Column(
                  children: <Widget>[
                    Expanded(
                      child: Hero(
                          tag: "${videoitem.id}",
                          child: Container(
                            width: double.infinity,
                            child: Image.network(
                              "${videoitem.cover}@320w_200h.jpg",
                              fit: BoxFit.fitWidth,
                            ),
                          )),
                    ),
                    Container(
                      height: 50,
                      color: Colors.grey[800],
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(left: 20),
                        width: double.infinity,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: Colors.grey[700],
                            borderRadius: BorderRadius.circular(22)),
                        child: Text(
                          "发个友善的弹幕见证一下",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: _SliverAppBarDelegate(
                  maxHeight: 50,
                  minHeight: 50,
                  child: Container(
                    color: Colors.white,
                    child: TabBar(
                      controller: _tabController,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.pinkAccent,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.pinkAccent,
                      tabs: <Widget>[
                        Tab(
                          text: "简介",
                        ),
                        Tab(
                          text: "评论",
                        )
                      ],
                    ),
                  )),
            ),
          ];
        },
        body: _getvideodetailisok
            ? TabBarView(
                controller: _tabController,
                children: <Widget>[
                  VideoDetailPage(videoItemFromJson, videoitem),
                  ReviewsPage(
                    videoitem.aid,
                  ),
                ],
              )
            : Center(child: Text("正在加载")),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;
  _SliverAppBarDelegate({
    @required this.minHeight,
    @required this.maxHeight,
    @required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "no";
  }
}
