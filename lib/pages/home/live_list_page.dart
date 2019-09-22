import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import "package:flutter_MyBilibili/model/jsonmodel/LiveItem.dart";
import 'package:flutter_MyBilibili/pages/home/live_play_page.dart';
import 'package:flutter_MyBilibili/tools/MyMath.dart';
import 'package:flutter_MyBilibili/util/BilibiliAPI/live_api.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class LiveListViewPage extends StatefulWidget {
  @override
  _LiveListViewPageState createState() => _LiveListViewPageState();
}

class _LiveListViewPageState extends State<LiveListViewPage>
    with AutomaticKeepAliveClientMixin<LiveListViewPage> {
  final List _list = [];
  ScrollController _listviewscrollController =
      ScrollController(); //listview的控制器
  ScrollController _gridviewscrollController =
      ScrollController(); //gridview的控制器
  bool isaddok = false;
  @override
  void initState() {
    super.initState();
    addCard();
  }

  addCard() async {
    _list.addAll(await LiveApi.getLiveList());
    if (_list.length != 0) {
      isaddok = true;
    }
    if (this.mounted) {
      setState(() {});
    }
  }

  Future<void> _onRefresh() async {
    _list.clear();
    _list.addAll(await LiveApi.getLiveList());
    if (this.mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        //直播按钮
        onPressed: () {
          _onRefresh();
        },
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "我要直播",
            style: TextStyle(color: Colors.white, fontSize: 15),
            textAlign: TextAlign.center,
          ),
        ),
        backgroundColor: Colors.pink[300],
      ),
      body: buildLiveListView(),
    );
  }

  Widget buildLiveListView() {
    if (isaddok == true) {
      //判断是否加载出来数据
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          physics: AlwaysScrollableScrollPhysics(),
          controller: _listviewscrollController,
          itemCount: _list.length,
          itemBuilder: (context, i) {
            if (_list[i] is LivePartition) {
              return buildLivePartition(_list[i]);
            } else if (_list[i] is Banners) {
              return buildBanners(_list[i]);
            } else if (_list[i] is AreaCard) {
              return buildAreaCard(_list[i]);
            } else {
              return Container();
            }
          },
        ),
      );
    } else {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  buildAreaCard(AreaCard areaCard) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 0.7,
                crossAxisSpacing: 10,
                mainAxisSpacing: 5),
            itemCount: areaCard.list.length,
            itemBuilder: (context, i) {
              return Container(
                  child: Tab(
                icon: Image.network(
                  areaCard.list[i].cover,
                  fit: BoxFit.fitWidth,
                ),
                child: Text(
                  areaCard.list[i].title,
                  style: TextStyle(fontSize: 12),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ));
            },
          ),
        ),
        DrawLine.GreyLine(),
      ],
    );
  }

  buildLivePartition(LivePartition partition) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          padding: EdgeInsets.all(10),
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text("${partition.name}"),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 7, right: 7),
          child: GridView.builder(
            controller: _gridviewscrollController,
            shrinkWrap: true,
            physics: new NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 5.0,
                crossAxisSpacing: 5.0,
                crossAxisCount: 2,
                childAspectRatio: 1.1),
            itemCount: partition.lives.length,
            itemBuilder: (BuildContext contex, int i) {
              return buildCard(partition.lives[i]);
            },
          ),
        ),
        DrawLine.GreyLine(),
      ],
    );
  }

  buildCard(LiveItem carditem) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LivePlayPage(
              carditem.roomid.toString(),
              cover: carditem.face,
              userName: carditem.uname,
            ),
          ),
        );
      },
      child: Container(
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              flex: 4,
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: Image.network(carditem.user_cover+"@320w_200h",fit: BoxFit.cover,),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.fromLTRB(5, 10, 5, 5),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Color.fromRGBO(0, 0, 0, 0),
                                Colors.black45
                              ])),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  carditem.uname,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                  maxLines: 1,
                                ),
                              ),
                              Icon(
                                BIcon.live_people,
                                size: 18,
                                color: Colors.white,
                              ),
                              Text(
                                MyMath.intToString(carditem.online),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12),
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            ),
            Expanded(
              flex: 1,
              child:  Container(
                padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Text(
                  carditem.title,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                  maxLines: 1,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                  child: Text(
                    "${carditem.area_name}",
                    style: TextStyle(color: Colors.grey, fontSize: 13),
                    maxLines: 1,
                  ),
                ))
          ],
        ),
      ),
    );
  }

  buildBanners(Banners banners) {
    return Container(
      height: 100,
      margin: EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Swiper(
          itemCount: banners.list.length,
          itemBuilder: (context, i) {
            return Container(
              child: Image.network(
                banners.list[i].pic,
                fit: BoxFit.fitWidth,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
