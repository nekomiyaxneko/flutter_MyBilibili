import 'dart:typed_data';
import 'dart:ui';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_MyBilibili/model/video_detail_item.dart';
import 'package:flutter_MyBilibili/tools/MyMath.dart';
import 'package:flutter_MyBilibili/views/danmaku/chewie_custom_with_danmaku.dart';
import 'package:xml/xml.dart' as xml;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/home/ReviewsPage.dart';
import 'package:flutter_MyBilibili/pages/home/video_detail_page.dart';
import 'package:flutter_MyBilibili/util/video_api.dart';
import 'package:flutter_MyBilibili/views/danmaku/danmaku_api.dart';
import 'package:flutter_MyBilibili/views/danmaku/danmaku_controller.dart';
import 'package:flutter_MyBilibili/views/danmaku/danmaku_item.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_player/video_player.dart';

class VideoPlayPageWithDanmaku extends StatefulWidget {
  final String aid;
  VideoPlayPageWithDanmaku(this.aid);
  @override //视频基本信息，av号封面
  _VideoPlayPageWithDanmakuState createState() =>
      _VideoPlayPageWithDanmakuState();
}

class _VideoPlayPageWithDanmakuState extends State<VideoPlayPageWithDanmaku> {
  var _videoplayscaffoldkey = new GlobalKey<ScaffoldState>(); //key的用法
  String aid;
  String msg="正在初始化";
  int replayCount = 0;
  int page = 0;
  int qn = 64;
  VideoDetailItem videoDetailItem; //视频详细信息，介绍等
  TabController _tabController =
      TabController(length: 2, vsync: AnimatedListState());
  VideoPlayerController _videoController;
  ChewieController _chewieController;
  List<DanmakuItem> _preList = [];
  DanmakuController _danmakuController;
  bool _getvideodetailisok = false;
  @override
  void initState() {
    aid = widget.aid;
    init();
    super.initState();
  }

  @override
  void dispose() {
    _danmakuController?.dispose();
    _tabController?.dispose();
    _chewieController?.dispose();
    _videoController?.dispose();
    super.dispose();
  }

  init() async {
    await getDetail();
    await initVideo();
  }

  Future<void> getDetail() async {
    videoDetailItem = await VideoApi.getVideoDetail(aid);
    if (videoDetailItem != null) {
      _getvideodetailisok = true;
    }
    else{
      Fluttertoast.showToast(msg: "获取视频信息失败");
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> getDanmaku() async {
    var data = await DanmakuApi.getDanmakuByUrl(
        videoDetailItem.data.pages[page].dmlink);
    if (data != null) {
      xml.XmlDocument document = xml.parse(data);
      var res = document.findAllElements("d").toList();
      for (int i = 0; i < res.length; i++) {
        var item = res[i];
        String msg = item.firstChild.toString();
        String p = item.attributes[0].value.toString();
        List<String> ps = p.split(",");
        int time = (double.parse(ps[0]) * 1000.0).toInt();
        _preList.add(DanmakuItem(msg, time));
      }
      //排序
      _preList.sort((DanmakuItem a, DanmakuItem b) {
        return a.duration.compareTo(b.duration);
      });
    }
    _danmakuController = DanmakuController(_preList);
    setState(() {});
  }

  //显示提示
  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _videoplayscaffoldkey.currentState.showSnackBar(snackBar);
  }
  //显示进度条下的提示
  setMsg(String s){
    setState(() {
      msg=s;
    });
  }
  Future<void> initVideo() async {
    if (videoDetailItem == null) {
      return;
    }
    setMsg("正在获取弹幕");
    await getDanmaku();
    setMsg("正在获取视频链接");
    var url = await VideoApi.getVideoPlayUrlV2(
        videoDetailItem.data.pages[page].cid,
        qn: qn);
    if (url == null) {
      Fluttertoast.showToast(msg: "获取视频链接失败");
      setMsg("获取视频链接失败");
      return;
    }
    setMsg("正在缓冲视频");
    if (url is String) {
      _videoController = VideoPlayerController.network(
        url,
      )..initialize().then((_) {
          setState(() {
            _chewieController = ChewieController(
              videoPlayerController: _videoController,
              placeholder: Center(
                child: Text(
                  "正在缓冲",
                  style: TextStyle(color: Colors.white30),
                ),
              ),
              autoPlay: true,
              aspectRatio: _videoController.value.size.aspectRatio,
              allowedScreenSleep: false,
              customControls: ChewieCustomWithDanmaku(_danmakuController),
            );
          });
        });
    }
  }

  // void setVideoUrlTemp() async {
  //   _videoController = VideoPlayerController.network(
  //     "http://upos-hz-mirrorakam.akamaized.net/upgcxcode/80/50/67185080/67185080-1-6.mp4?e=ig8euxZM2rNcNbRBhwdVhoM17WdVhwdEto8g5X10ugNcXBB_&deadline=1568605530&dynamic=1&gen=playurl&oi=1886944469&os=akam&platform=html5&rate=150000&trid=615451b499864313ab4585fee55a1490&uipk=5&uipv=5&um_deadline=1568605530&um_sign=be0bcb66049aa20c832c107e2637dc7f&upsig=691c2f0634c0abdca873aae2df85ff3e&uparams=e,deadline,dynamic,gen,oi,os,platform,rate,trid,uipk,uipv,um_deadline,um_sign&hdnts=exp=1568605530~hmac=b8aa313bbd254137d71781bcd853cd811708675de85a324b3bfca98a863963d2&mid=0",
  //   )..initialize().then((_) {
  //       if (this.mounted) {
  //         setState(() {});
  //       }
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _videoplayscaffoldkey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            MediaQuery.of(context).size.width * 9.0 / 16.0 -
                MediaQueryData.fromWindow(window).padding.top +
                30),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          centerTitle: true,
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            margin: EdgeInsets.only(bottom: 30),
            color: Colors.black,
            width: double.infinity,
            child: _chewieController != null
                ? Chewie(
                    controller: _chewieController,
                  )
                : Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(msg,style: prefix0.TextStyle(color: Colors.grey),)
                      ],
                    ),
                  ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: _showCheckDialog,
            )
          ],
          bottom: TabBar(
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
                    text: videoDetailItem == null
                        ? "评论"
                        : "评论 ${MyMath.intToString(videoDetailItem.data.stat.reply)}",
                  )),
            ],
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
          : Center(child: Text("正在加载")),
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
            Image.network(videoDetailItem.data.pic + "@320w_200h"),
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

//可以将普通widget放进去
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
