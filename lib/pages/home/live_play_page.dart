import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/tools/MyMath.dart';
import 'package:flutter_MyBilibili/util/BilibiliAPI/live_api.dart';
import 'package:flutter_MyBilibili/views/live/live_danmaku_page.dart';
import 'package:flutter_MyBilibili/views/my_chewie_custom.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:video_player/video_player.dart';

class LivePlayPage extends StatefulWidget {
  final String roomid;
  final String cover;
  final String userName;
  LivePlayPage(this.roomid, {this.cover, this.userName});
  @override
  _LivePlayPageState createState() => _LivePlayPageState();
}

class _LivePlayPageState extends State<LivePlayPage> {
  VideoPlayerController _videoController;
  ChewieController _chewieController;
  TabController _tabController;
  List<String> _urlList = [];
  LiveInfo _info;
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    _tabController=TabController(length: 2,vsync: AnimatedListState());
    _initLive();
    super.initState();
  }

  _initLive() async {
    _info = await LiveApi.getLiveInfo(widget.roomid);
    if (_info != null) {
      if (_info.liveStatus == 1) {
        await _getLiveUrl();
      }
    }
  }

  _getLiveUrl() async {
    var res = await LiveApi.getLivePlayUrl(widget.roomid);
    if (res == null) {
      return;
    } else {
      _urlList.addAll(res);
    }
    if (_urlList.length > 0) {
      _setLiveUrl(_urlList[index]);
    }
  }

  _setLiveUrl(String url) {
    _videoController = VideoPlayerController.network(
      url,
    )..initialize().then(
        (_) {
          if (mounted)
            setState(() {
              _chewieController = ChewieController(
                  videoPlayerController: _videoController,
                  placeholder: Center(
                    child: Text(
                      "正在缓冲",
                      style: TextStyle(color: Colors.white30),
                    ),
                  ),
                  aspectRatio: _info.isPortrait
                      ? MediaQuery.of(context).size.width /
                          MediaQuery.of(context).size.height
                      : 16 / 9,
                  autoPlay: true,
                  allowedScreenSleep: false,
                  customControls: MyChewieMaterialControls(),
                  isLive: true,
                  allowFullScreen: !_info.isPortrait);
            });
        },
      );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController?.dispose();
    _chewieController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _info != null ? buildLiveRoom() : buildLoadingView();
  }

  Widget buildLoadingView() {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Container(
            height: 80,
            child: Tab(
                icon: Image.asset("images/ic_loading.png"),
                child: Text("正在初始化直播间")),
          )),
    );
  }

  Widget buildLiveRoom() {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: _info.isPortrait
            ? Size.fromHeight(MediaQuery.of(context).size.height)
            : Size.fromHeight(MediaQuery.of(context).size.width * 9 / 16-MediaQueryData.fromWindow(window).padding.top),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text(_info.title,
              style: TextStyle(color: Colors.white, fontSize: 15)),
          flexibleSpace: Container(
            height: double.infinity,
            width: double.infinity,
            child: _chewieController == null
                ? Center(child: CircularProgressIndicator())
                : Chewie(
                    controller: _chewieController,
                  ),
          ),
        ),
      ),
      body: buildLiveInfo(),
    );
  }

  Widget buildLiveInfo() {
    if (_info.isPortrait) {
      return Container();
    }
    return Column(
      children: <Widget>[
        TabBar(
          controller: _tabController,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Theme.of(context).primaryColor,
          labelColor: Theme.of(context).primaryColor,
          tabs: <Widget>[
            Container(
              height: 35,
              child: Tab(
                text: "互动",
              ),
            ),
            Container(
              height: 35,
              child: Tab(
                text: "主播",
              ),
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: <Widget>[
              buildLiveDanmakuList(),
              buildLiverInfo(),
            ],
          ),
        )
      ],
    );
  }
  Widget buildLiverInfo(){
    return ListView(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: ClipOval(
                  child: Image.network(
                    widget.cover,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.userName,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  Text(
                    "房间号: ${widget.roomid}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    "粉丝: ${MyMath.intToString(_info.attention)} 观看 ${MyMath.intToString(_info.online)}",
                    style: TextStyle(color: Colors.grey),
                  ),
                  
                  Text(
                    "${_info.areaName}",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
              Expanded(
                child: Container(
                  height: 40,
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {},
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    child: Text("+关注"),
                  ),
                ),
              )
            ],
          ),
        ),
//        HtmlWidget(
//          _info.description
//        ),
      ],
    );
  }

  Widget buildLiveDanmakuList(){
    return LiveDanmakuPage(int.parse(widget.roomid));
  }
}

class LiveInfo {
  String title;
  int online;
  bool isPortrait;

  ///ture为竖屏，flase为横屏
  int attention;
  int liveStatus;
  String description;
  String background;
  String userCover;

  ///0未开播，1开播,2轮播-不好播放
  String areaName;
  LiveInfo.fromJson(Map<String, dynamic> jd) {
    title = jd["title"];
    online = jd["online"];
    isPortrait = jd["is_portrait"];
    liveStatus = jd["live_status"];
    areaName = jd["area_name"];
    attention = jd["attention"];
    description = jd["description"];
    background = jd["background"];
    userCover = jd["user_cover"];
  }
}
