import 'dart:typed_data';
import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/video_detail_item.dart';
import 'package:flutter_MyBilibili/pages/home/ReviewsPage.dart';
import 'package:flutter_MyBilibili/pages/home/video_detail_page.dart';
import 'package:flutter_MyBilibili/util/video_api.dart';
import 'package:flutter_MyBilibili/views/my_chewie_custom.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPage extends StatefulWidget {
  final String aid;
  VideoPlayPage(this.aid);
  @override//视频基本信息，av号封面
  _VideoPlayPageState createState() => _VideoPlayPageState();
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  var _videoplayscaffoldkey = new GlobalKey<ScaffoldState>(); //key的用法
  String aid;
  int replayCount=0;
  int page=0;
  int qn=64;
  VideoDetailItem videoDetailItem;//视频详细信息，介绍等
  TabController _tabController =TabController(length: 2, vsync: AnimatedListState());
  VideoPlayerController _videoController;
  ChewieController _chewieController;
  bool _getvideodetailisok = false;
  @override
  void initState() {
    aid=widget.aid;
    init();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    if(_chewieController !=null) _chewieController.dispose();
    if(_videoController !=null) _videoController.dispose();
    super.dispose();
  }

  //初始化所有
  init()async{
    await getDetail();
    setVideoUrl();
  }

  Future<void> getDetail() async {
    videoDetailItem =await VideoApi.getVideoDetail(aid);
    if (videoDetailItem != null) {
      _getvideodetailisok = true;
    }
    if (this.mounted) {
      setState(() {});
    }
  }
  //显示提示
  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _videoplayscaffoldkey.currentState.showSnackBar(snackBar);
  }

  Future<void> setVideoUrl() async {
    if(videoDetailItem==null){
      return;
    }
    var url = await VideoApi.getVideoPlayUrlV2(videoDetailItem.data.pages[page].cid,qn: qn);
    if (url == null) {
      Fluttertoast.showToast(msg: "获取视频播放地址失败");
      return;
    }
    if (url is String) {
      _videoController = VideoPlayerController.network(
        url,
      )..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              placeholder: Center(
                child: Text("正在缓冲",style: TextStyle(color: Colors.white30),),
              ),
              autoPlay: true,
              aspectRatio: _videoController.value.size.aspectRatio,
              allowedScreenSleep: false,
              customControls: MyChewieMaterialControls(),
            );
          });
        });
    }
  }

  Future<void> setVideoUrlTemp() async {
    _videoController = VideoPlayerController.network(
      "http://112.13.207.162/upgcxcode/99/26/122342699/122342699-1-64.flv?expires=1571295000&platform=android&ssig=pfP5TAFNXT-rc_XaV1S0Zw&oi=1972571493&trid=62e4ce8719924966859896e64564721d&nfb=maPYqpoel5MI3qOUX6YpRA==&nfc=1&mid=0",
    )..initialize().then((_) {
        if (this.mounted) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              placeholder: Center(
                child: Text("正在缓冲",style: TextStyle(color: Colors.white30),),
              ),
              autoPlay: true,
              aspectRatio: _videoController.value.size.aspectRatio,
              allowedScreenSleep: false,
              customControls: MyChewieMaterialControls(),
              startAt: Duration(seconds: 5)
            );
          });
        }
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _videoplayscaffoldkey,
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.width * 9.0 / 16.0-MediaQueryData.fromWindow(window).padding.top+30),
        child: AppBar(
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: true,
          flexibleSpace: GestureDetector(
            onDoubleTap: () {
              _videoController.value.isPlaying
                  ? _chewieController.pause()
                  : _chewieController.play();
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 30),
              color: Colors.black,
              width: double.infinity,
              child: _chewieController != null
                  ? Chewie(
                      controller: _chewieController,
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: _showCheckDialog,
            )
          ],
          bottom: GetPreferredSizeWidget(
            Container(
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
                        Container(
                          height: 30,
                          child: Tab(
                            text: "简介",
                          ),
                        ),
                        Container(
                          height: 30,
                          child: Tab(
                            text:replayCount==0?"评论":"评论 ${replayCount.toString()}",
                          )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                        margin: EdgeInsets.only(right: 40),
                        alignment: Alignment.centerRight,
                        child: AnimatedContainer(
                          //TODO 弹幕开关
                          duration: Duration(milliseconds: 500),
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
      ),
      body: _getvideodetailisok
          ? TabBarView(
              controller: _tabController,
              children: <Widget>[
                VideoDetailPage(videoDetailItem, aid),
                ReviewsPage(
                  aid,
                  replayCount,
                ),
              ],
            )
          : Center(child: Text("正在加载"),
          ),
    );
    
  }

  _showCheckDialog() async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(15),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
              Text(
              '是否保存封面?',
              textAlign: TextAlign.center,
            ),
            Image.network(videoDetailItem.data.pic+"@320w_200h"),
          ],
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
              await _saveCover(videoDetailItem.data.pic);
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
      Fluttertoast.showToast(msg: "保存成功 路径" + result);
    } else {
      Fluttertoast.showToast(msg: "申请权限失败");
    }
  }
}

class GetPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }

  GetPreferredSizeWidget(
    this.child, {
    Key key,
  }) : super(key: key);

  @override
  Size get preferredSize => getSize();

  Size getSize() {
    return new Size(44.0, 44.0);
  }
}
