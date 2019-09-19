import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/pages/home/VideoPlayPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class C70thAnniversaryPage extends StatefulWidget {
  @override
  _C70thAnniversaryPageState createState() => _C70thAnniversaryPageState();
}

class _C70thAnniversaryPageState extends State<C70thAnniversaryPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _list = [
    Banners([
      Banner(
          "http://i0.hdslb.com/bfs/archive/fc523c90d05bade49143294262a3a297da2a5d55.jpg"),
      Banner(
          "http://i0.hdslb.com/bfs/archive/77da52bb418a4d7f959805d68779cc677c0cb71c.jpg"),
      Banner(
          "http://i0.hdslb.com/bfs/archive/02127e444fd82aab723c7747f57d5c903c602605.jpg"),
    ]),
    VideoTile("手造中国", [
      VideoItem(
          "15500607",
          "http://i1.hdslb.com/bfs/archive/69b341351180227d90b54cd61297177b643642c5.jpg",
          "91岁仍坚守方桌，剪艺宗师袁秀莹与她的剪纸人生",
          "趣味科普人文",
          "4.6万",
          "163",
          "3:23"),
      VideoItem(
          "10146180",
          "http://i0.hdslb.com/bfs/archive/0baf3c2bc01200caecffdefd1eb9908d474aa4ac.jpg",
          "被称为中国三宝之一的它，却不及日本，面临失传",
          "趣味科普人文",
          "14.4万",
          "296",
          "4:17"),
      VideoItem(
          "13963830",
          "http://i0.hdslb.com/bfs/archive/2356a444ee4dd26bb830fe834dd3d1dddb4af955.jpg",
          "从一根青竹变成一摞纸，都发生了什么？",
          "趣味科普人文",
          "9万",
          "546",
          "3:02"),
      VideoItem(
          "15902489",
          "http://i2.hdslb.com/bfs/archive/2d21750c9cd9a3707c583a98e4a8fff3000c1c3e.jpg",
          "他用编竹子的手艺，编出了年收108亿的传奇",
          "趣味科普人文",
          "7.1万",
          "362",
          "4:25"),
    ]),
    BigCover(
        "http://i1.hdslb.com/bfs/archive/685562c7df25a391723490d36354fd1440c0e2d4.jpg",
        "68129825",
        "外交高手”大熊猫：为国卖萌，应该的",
        "9968",
        "42"),
    BigCover(
        "http://i0.hdslb.com/bfs/archive/ee5829877e348ca9b69e7fb88dd72e3925514dce.jpg",
        "68098480",
        "黄河亮了！“人民红”点亮黄河沿岸 向祖国表白",
        "2381",
        "9"),
    BigCover(
        "http://i2.hdslb.com/bfs/archive/05d92363b590b1bf013dd6f9d3377d16e5557740.png",
        "3924328",
        "我在故宫修文物（2016）",
        "532.4万",
        "10万"),
  ];

  Future<Null> _onrefresh() async {
    await Future.delayed(Duration(seconds: 1), () {
      if (mounted)
        setState(() {
          _refreshController.refreshCompleted();
        });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      onRefresh: _onrefresh,
      controller: _refreshController,
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, i) {
          Widget widget = Container();
          if (_list[i] is Banners) {
            widget = buildTopBanners(_list[i]);
          } else if (_list[i] is VideoTile) {
            widget = buildBangumiTile(_list[i]);
          } else if (_list[i] is BigCover) {
            widget = buildBigCover(_list[i]);
          }
          return widget;
        },
      ),
    );
  }

  buildTopBanners(Banners banners) {
    return Container(
      height: 220,
      child: Stack(
        children: <Widget>[
          Container(
            child: Image.network(
              "http://i0.hdslb.com/bfs/archive/2e92d79c8a2a5a87f0d91ab1d493d09f5c1b2ec6.jpg",
              fit: BoxFit.fitWidth,
            ),
          ),
          Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child: Container(
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Swiper(
                    autoplay: true,
                    pagination: SwiperPagination(
                      alignment: Alignment.bottomRight,
                      builder: DotSwiperPaginationBuilder(
                        size: 7,
                        activeSize: 7,
                        color: Colors.white,
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    itemCount: banners.regions.length,
                    itemBuilder: (context, i) {
                      return Container(
                        width: double.infinity,
                        child: Image.network(
                          banners.regions[i].cover+ "@600w_600h",
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                ),
              ))
        ],
      ),
    );
  }

  buildBangumiTile(VideoTile videoTile) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            child: Text(videoTile.title),
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            padding: EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: videoTile.list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.9,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  print(videoTile.list[i].goto);
                  if (videoTile.list[i].goto == VideoItem.av) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            VideoPlayPage(videoTile.list[i].parama),
                      ),
                    );
                  }
                },
                child: Card(
                  margin: EdgeInsets.all(0),
                  elevation: 0.8,
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        flex: 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(5),
                              topRight: Radius.circular(5)),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(
                                    videoTile.list[i].cover+ "@320w_200h",
                                  ),
                                  fit: BoxFit.cover),
                            ),
                            child: Container(
                              padding: EdgeInsets.all(5),
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.center,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromRGBO(0, 0, 0, 0),
                                    Colors.black54
                                  ],
                                ),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    BIcon.play,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Text(
                                    " ${videoTile.list[i].play} ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(BIcon.danmaku,
                                      color: Colors.white, size: 16),
                                  Text(
                                    " ${videoTile.list[i].danmaku} ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Expanded(
                                    child: Text("${videoTile.list[i].len}",
                                        textAlign: TextAlign.right,
                                        style: TextStyle(color: Colors.white)),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3,
                          child: Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  videoTile.list[i].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  videoTile.list[i].desc,
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  buildBigCover(BigCover bigCover) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      height: 190,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.network(
                bigCover.cover+ "@600w_600h",
                fit: BoxFit.fitWidth,
              ),
            ),
            Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.black45, Color.fromRGBO(0, 0, 0, 0)]),
                  ),
                  child: Text(
                    bigCover.title,
                    style: TextStyle(color: Colors.white),
                    maxLines: 1,
                  ),
                )),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [Colors.black54, Color.fromRGBO(0, 0, 0, 0)]),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        BIcon.play,
                        color: Colors.white,
                        size: 16,
                      ),
                      Text(
                        " ${bigCover.play} ",
                        style: TextStyle(color: Colors.white),
                      ),
                      Icon(BIcon.danmaku, color: Colors.white, size: 16),
                      Text(
                        " ${bigCover.danmaku} ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                )),
            Positioned(
              right: 10,
              bottom: 10,
              child: Icon(BIcon.play_action, size: 50, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}

//横幅
class Banner {
  String cover;
  String title;
  Banner(this.cover, {this.title});
}

//横幅列表
class Banners {
  List<Banner> regions;
  Banners(this.regions);
}

///单个视频
class VideoItem {
  static String av = "av";
  String title;
  String desc;
  String play;
  String danmaku;
  String cover;
  String goto;
  String parama;
  String len;
  VideoItem(this.parama, this.cover, this.title, this.desc, this.play,
      this.danmaku, this.len,
      {this.goto = "av"});
}

///多个视频
class VideoTile {
  List<VideoItem> list;
  String title;
  VideoTile(
    this.title,
    this.list,
  );
}

class BigCover {
  static String av = "av";
  String goto;
  String param;
  String cover;
  String title;
  String play;
  String danmaku;
  BigCover(this.cover, this.param, this.title, this.play, this.danmaku,
      {this.goto = "av"});
}
