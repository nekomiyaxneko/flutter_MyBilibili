import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/hot_item.dart';
import 'package:flutter_MyBilibili/pages/home/VideoPlayPage.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';
import 'package:flutter_MyBilibili/util/BilibiliAPI/bilibili_dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HotListPage extends StatefulWidget {
  const HotListPage({Key key});
  @override
  _HotListPageState createState() => _HotListPageState();
}

class _HotListPageState extends State<HotListPage>
    with AutomaticKeepAliveClientMixin<HotListPage> {
  _HotListPageState({
    Key key,
  });
  final List _hotList = [];
  final List<HotTopItem> _topList = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    Widget body;
    body = buildList();
    return body;
  }

  Widget buildList() {
    return SmartRefresher(
      enablePullUp: true,
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      footer: CustomFooter(
        builder: (context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.loading) {
            body = CupertinoActivityIndicator();
          } else if (mode == LoadStatus.idle) {
            body = Text("上划加载更多");
          }
          else if(mode == LoadStatus.canLoading){
            body = Text("松开加载更多");
          } 
          else {
            body = Text("已经到达热门尽头了");
          }
          return Container(
            height: 20,
            alignment: Alignment.center,
            child: body,
          );
        },
      ),
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          buildTopList(),
          buildHotList(),
        ],
      ),
    );
  }

  buildTopList() {
    return Container(
      height: 60,
      margin: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: _topList.map((item) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.network(
                item.icon,
                height: 40,
              ),
              Text(
                item.title,
                style: TextStyle(color: Colors.grey),
              )
            ],
          );
        }).toList(),
      ),
    );
  }

  buildHotList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: _hotList.length,
      shrinkWrap: true,
      itemBuilder: (context, i) {
        Widget view;
        if (_hotList.elementAt(i) is HotVideoItem) {
          view = HotVideoView(_hotList[i]);
        } else if (_hotList.elementAt(i) is HotUpItem) {
          view = HotUpView(_hotList[i]);
        } else {
          view = Container(
            height: 0.1,
          );
        }
        return view;
      },
    );
  }

  Future<dynamic> getTopList() async {
    List<HotTopItem> tempList = List<HotTopItem>();
    var res = await BilibiliDio.getUrl(
      "https://app.bilibili.com/x/v2/show/popular/index?build=5470400&mobi_app=android",
    );
    try {
      if (res != null) {
        Map<String, dynamic> jd = res.data;
        if (jd["config"]["top_items"] != null) {
          for (Map<String, dynamic> item in jd["config"]["top_items"]) {
            tempList.add(HotTopItem.fromJson(item));
          }
        }
        return tempList;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<dynamic> getHotList() async {
    List tempList = List();
    int idx = _hotList.length;
    try {
      var res = await BilibiliDio.getUrl(
        "https://app.bilibili.com/x/v2/show/popular/index?build=5470400&mobi_app=android&idx=$idx",
      );

      if (res != null) {
        Map<String, dynamic> jd = res.data;
        if (jd["data"] != null) {
          for (Map<String, dynamic> item in jd["data"]) {
            if (item["goto"] == "av")
              tempList.add(HotVideoItem.fromJson(item));
            else if (item["goto"] == "mid")
              tempList.add(HotUpItem.fromJson(item));
          }
        }
        return tempList;
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<Null> _onLoading() async {
    if (_hotList.length >= 100) {
      _refreshController.loadNoData();
    } else {
      var res = await getHotList();
      if (res != null) {
        _hotList.addAll(res);
        _refreshController.loadComplete();
      }
    }
    if (mounted) setState(() {});
  }

  Future<Null> _onRefresh() async {
    isLoading = true;
    _hotList.clear();
    _topList.clear();
    var topres = await getTopList();
    var hotres = await getHotList();
    if (topres != null && topres is List<HotTopItem>) {
      _topList.addAll(topres);
    }
    if (hotres != null) {
      _hotList.addAll(hotres);
    }
    if (hotres != null && topres != null) {
      _refreshController.refreshCompleted();
    } else {
      _refreshController.refreshFailed();
    }
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  @override
  bool get wantKeepAlive => true;
}

openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "no";
  }
}

class HotVideoView extends StatelessWidget {
  final HotVideoItem item;
  HotVideoView(this.item);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          new MaterialPageRoute(
            builder: (contex) => new VideoPlayPage(item.aid),
          ),
        );
      },
      child: Container(
        //height: 120,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    //封面
                    flex: 1,
                    child: Container(
                      height: 95,
                      alignment: Alignment.bottomRight,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(2)),
                          image: DecorationImage(
                              image: NetworkImage(
                                item.cover + "@320w_200h",
                              ), //封面
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                        margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.black54,
                        ),
                        child: Text(
                          item.coverRightText_1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    //详情
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          item.title,
                          style: TextStyle(fontSize: 14),
                          maxLines: 2,
                        ),
                        item.rcmdReasonStyle == null
                            ? Container(
                                height: 20,
                              )
                            : Container(
                                padding: EdgeInsets.fromLTRB(3, 1, 3, 1),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  color: Colors.orange[400],
                                ),
                                child: Text(
                                  item.rcmdReasonStyle.text,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        Text(
                          item.rightDesc_1,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                        Text(
                          "${item.rightDesc_2}",
                          textAlign: TextAlign.start,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            DrawLine.GreyLine(),
          ],
        ),
      ),
    );
  }
}

class HotUpView extends StatelessWidget {
  final HotUpItem item;
  HotUpView(this.item);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 190,
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                ClipOval(
                  child: Image.network(
                    item.cover + "@100w_100h",
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item.title,
                      style: TextStyle(fontSize: 16),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(5, 2, 5, 2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.orange[400],
                      ),
                      child: Text(
                        item.rcmdReasonStyle.text,
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: 30,
                      width: 80,
                      child: OutlineButton(
                        onPressed: () {},
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                        color: Theme.of(context).primaryColor,
                        disabledTextColor: Colors.white,
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          "+ 关注",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: item.upVideoList.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  VideoPlayPage(item.upVideoList[i].aid)));
                    },
                    child: HotUpVideoView(item.upVideoList[i]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HotUpVideoView extends StatelessWidget {
  final UpVideoItem item;
  HotUpVideoView(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 130,
      margin: EdgeInsets.fromLTRB(0, 10, 10, 0),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
                decoration: BoxDecoration(
                  //封面图
                  image: DecorationImage(
                      image: NetworkImage(item.cover + "@320w_200h"),
                      fit: BoxFit.fitHeight),
                  borderRadius: BorderRadius.circular(5)
                ),
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.only(top: 30, bottom: 3, left: 5, right: 5),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(0, 0, 0, 0.01),
                          Colors.black54
                        ]),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            BIcon.play,
                            color: Colors.white,
                            size: 15,
                          ),
                          Text(
                            "${item.coverLeftText_1}   ",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Text(
                          "${item.coverRighText}",
                          textAlign: TextAlign.right,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          Expanded(
              flex: 1,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Text(
                    item.title,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    maxLines: 2,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
