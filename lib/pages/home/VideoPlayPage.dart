import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/VideoItem.dart';
import 'package:flutter_MyBilibili/model/VideoItemFromJson.dart';
import 'package:flutter_MyBilibili/pages/home/ReviewsPage.dart';
import 'package:flutter_MyBilibili/pages/home/video_detail_page.dart';
import 'package:flutter_MyBilibili/tools/sliver_appbar_delegate.dart';
import 'package:flutter_MyBilibili/util/GetUtilBilibili.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VideoPlayPage extends StatefulWidget {
  @override
  final VideoItem videoitem; //视频基本信息，av号封面
  VideoPlayPage(this.videoitem);
  _VideoPlayPageState createState() => _VideoPlayPageState(videoitem);
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
  _VideoPlayPageState(this.videoitem);
  @override
  void initState() {
    getDetail();
    //设置封面滚动监听，隐藏标题
    _nestedScrollViewController.addListener(() {
      if (_nestedScrollViewController.offset > 110 && _isHideTitle == true) {
        setState(() {
          _isHideTitle = false;
        });
      } else if (_nestedScrollViewController.offset <= 110 &&
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
    if (this.mounted) {
      setState(() {});
    }
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
                child: GestureDetector(
                  onTap: (){
                    _nestedScrollViewController.jumpTo(0);
                  },
                  child: Text("立即播放"),
                ),
              ),
              elevation: 1,
              centerTitle: true,
              forceElevated: true,
              expandedHeight: 170,
              //floating: true,
              //snap: true,
              pinned: true,
              titleSpacing: NavigationToolbar.kMiddleSpacing,
              automaticallyImplyLeading: true,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                centerTitle: true,
                background: Hero(
                  tag: "${videoitem.id}",
                  child: GestureDetector(
                    onTap: () {
                      _showCheckDialog(videoitem.cover);
                    },
                    child: Container(
                      width: double.infinity,
                      child: Image.network(
                        "${videoitem.cover}@320w_200h.jpg",
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                )
              ],
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                maxHeight: 40,
                minHeight: 40,
                child: Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
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
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                            margin: EdgeInsets.only(right: 40),
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(10)),
                              child: Icon(
                                BIcon.danmu_off,
                                color: Colors.grey[600],
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
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

  _showCheckDialog(String url) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(15),
        content: Text(
          '是否保存封面?',
          textAlign: TextAlign.center,
        ),
        actions: <Widget>[
          FlatButton(
            child: Text("取消"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          FlatButton(
            child: Text("确定"),
            onPressed: () async {
              Navigator.pop(context);
              await _saveCover(url);
            },
          ),
        ],
      ),
    );
  }

  _saveCover(String url) async {
     Fluttertoast.showToast(msg: "正在保存");
    //先检查权限
    await PermissionHandler().requestPermissions([PermissionGroup.storage]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission == PermissionStatus.granted) {
      var response = await Dio()
          .get(url, options: Options(responseType: ResponseType.bytes));
      final result =
          await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      Fluttertoast.showToast(msg: "保存成功 路径"+result);
    } else {
      Fluttertoast.showToast(msg: "申请权限失败");
    }
  }
   
}


openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "no";
  }
}
