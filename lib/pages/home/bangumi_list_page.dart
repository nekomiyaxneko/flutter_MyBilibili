import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/me/LoginPage.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BangumiListPage extends StatefulWidget {
  @override
  _BangumiListPageState createState() => _BangumiListPageState();
}

class _BangumiListPageState extends State<BangumiListPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List _list = [
    Banners(
      [
        Banner(
            "http://i0.hdslb.com/bfs/bangumi/a085f60bda7f18226accf3993b328e17f419c00d.jpg",
            "FGO动画专题页"),
        Banner(
            "http://i0.hdslb.com/bfs/bangumi/8c39135d5191acbe0f0108ede3dbc76b6342cd36.jpg",
            "少女前线 人形小剧场：第9话"),
        Banner(
            "http://i0.hdslb.com/bfs/bangumi/105c45fa8538c897e85e44f3811eda2de2d79b85.jpg",
            "风起绿林"),
        Banner(
            "http://i0.hdslb.com/bfs/bangumi/20429c37693f67e5310f3b4d02f96c2b7403a6ec.jpg",
            "【一周资讯】第37期"),
      ],
    ),
    Regions([
      Region(
          "http://i0.hdslb.com/bfs/bangumi/125ba229db0dcc3b5a9fe110ba3f4984ddc2c775.png",
          "番剧"),
      Region(
          "http://i0.hdslb.com/bfs/bangumi/2c782d7a8127d0de8667321d4071eebff01ea977.png",
          "国创"),
      Region(
          "http://i0.hdslb.com/bfs/bangumi/7a7d9db1911b7cbfdad44ae953dd5acc49ef5187.png",
          "时间表"),
      Region(
          "http://i0.hdslb.com/bfs/bangumi/76c03a7ca20815765c7f5bc17d320e0676e15a20.png",
          "索引"),
      Region(
          "http://i0.hdslb.com/bfs/bangumi/e713a764f9146b73673ba9b126d963aa50f4fc3b.png",
          "热门榜单"),
    ]),
    "登陆",
    BangumiTile("番剧推荐", [
      BangumiItem("猎兽神兵", "全12话", "会员抢先", "69.1万追番",
          "http://i0.hdslb.com/bfs/archive/81385f895a48a1c27a0e701218781908fb9d5dd2.jpg"),
      BangumiItem("鬼灭之刃", "更新至第24话", "会员抢先", "476.9万追番",
          "http://i0.hdslb.com/bfs/archive/efc989798673c8c374cad6e2b4fc555a8f0f3c2c.jpg"),
      BangumiItem("女高中生的虚度日常", "更新至第11话", "会员抢先", "171.1万追番",
          "http://i0.hdslb.com/bfs/archive/1c277223735cfe18a32f8130855a20c1a699f706.jpg"),
      BangumiItem("某科学的一方通行", "更新至第10话", "会员抢先", "217.2万追番",
          "http://i0.hdslb.com/bfs/archive/def29a30113e96248830b2a984c8feb6749252f4.jpg"),
    ]),
    BangumiTile("国创推荐", [
      BangumiItem("画江湖之不良人 第三季", "更新至第36话", "会员抢先", "132.8万系列追番",
          "http://i0.hdslb.com/bfs/archive/ad8fe0bbc56b951a57e02142b79b4e9e7137b2e3.jpg"),
      BangumiItem("阴阳师·平安物语", "全12话", "会员抢先", "140.8万系列追番",
          "http://i0.hdslb.com/bfs/archive/2e2198e297e98fe77b007710a3cefa9683e31898.jpg"),
      BangumiItem("我家大师兄脑子有坑 特别篇", "更新至第48话", "会员抢先", "196.8万系列追番",
          "http://i0.hdslb.com/bfs/archive/55cd9010e59c310b3ccf6281b4ec57bf44967054.jpg"),
      BangumiItem("更新至第9话", "斩兽之刃", "会员抢先", "43.9万系列追番",
          "http://i0.hdslb.com/bfs/archive/148be0d6209c7a7538998467f50dae3c6f21f322.jpg"),
    ]),
  ];
  Future<Null> _onrefresh() async {
    await Future.delayed(Duration(seconds: 1)).then((_) {
      _refreshController.loadComplete();
      if (mounted) setState(() {});
      print("load ok");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: false,
      controller: _refreshController,
      onRefresh: _onrefresh,
      child: ListView.builder(
        itemCount: _list.length,
        itemBuilder: (context, i) {
          Widget widget = Container();
          //TODO 判断item类型
          if (_list[i] is Banners) {
            widget = buildBanners(_list[i]);
          } else if (_list[i] is Regions) {
            widget = buildRegions(_list[i]);
          } else if (_list[i] is BangumiTile) {
            widget = buildBangumiTile(_list[i]);
          } else if (_list[i] is String) {
            widget = buildLogin();
          }
          return widget;
        },
      ),
    );
  }

  buildBanners(Banners banners) {
    return Container(
        margin: EdgeInsets.all(10),
        height: 192,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Swiper(
            itemCount: banners.regions.length,
            autoplay: true,
            pagination: SwiperPagination(
                alignment: Alignment.bottomRight,
                builder: DotSwiperPaginationBuilder(
                  color: Colors.white,
                  activeColor: Theme.of(context).primaryColor,
                )),
            itemBuilder: (context, i) {
              return Container(
                alignment: Alignment.bottomLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        banners.regions[i].cover,
                      ),
                      fit: BoxFit.fitHeight),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 30, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.01),
                          Colors.black54
                        ]),
                  ),
                  child: Text(
                    banners.regions[i].title,
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              );
            },
          ),
        ));
  }

  buildRegions(Regions regions) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: regions.regions.map(
              (i) {
                return Tab(
                  icon: Image.network(
                    i.icon,
                    fit: BoxFit.fitHeight,
                    height: 30,
                  ),
                  text: i.title,
                );
              },
            ).toList(),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  buildBangumiTile(BangumiTile bangumiTile) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                  child: Container(
                alignment: Alignment.centerLeft,
                child: Text(bangumiTile.title),
              )),
              Text("查看更多",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: bangumiTile.list.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10),
            itemBuilder: (context, i) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 5,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  bangumiTile.list[i].cover,
                                ),
                                fit: BoxFit.cover),
                          ),
                          child: Stack(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        begin: Alignment.center,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                      Color.fromRGBO(0, 0, 0, 0),
                                      Colors.black54
                                    ])),
                              ),
                              Positioned(
                                  left: 0,
                                  top: 0,
                                  child: Container(
                                    color: Colors.black26,
                                    padding: EdgeInsets.all(5),
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                    ),
                                  )),
                              Positioned(
                                right: 3,
                                top: 3,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Text(
                                    " 会员抢先 ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        backgroundColor: Colors.pink[300],
                                        fontSize: 12),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 5,
                                bottom: 5,
                                child: Text(
                                  bangumiTile.list[i].desc,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(bangumiTile.list[i].title),
                    ),
                    Expanded(
                      flex: 1,
                      child: Text(
                        bangumiTile.list[i].desc,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.center,
            child: Text(
              "换一换",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          Container(
            height: 0.5,
            color: Colors.grey[300],
          )
        ],
      ),
    );
  }

  buildLogin() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        height: 100,
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Image.asset(
          "images/bangumi_home_login_guide.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//横幅
class Banner {
  String cover;
  String title;
  Banner(this.cover, this.title);
}

//横幅列表
class Banners {
  List<Banner> regions;
  Banners(this.regions);
}

//分区列表
class Region {
  String icon;
  String title;
  Region(this.icon, this.title);
}

//分区
class Regions {
  List<Region> regions;
  Regions(this.regions);
}

///单个动漫
class BangumiItem {
  String title;
  String desc;
  String followView;
  String badge;
  String cover;
  BangumiItem(this.title, this.desc, this.badge, this.followView, this.cover);
}

///四格动漫
class BangumiTile {
  List<BangumiItem> list;
  String title;
  BangumiTile(this.title, this.list);
}
