//推荐视频
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/model/VideoItem.dart';
import 'package:flutter_MyBilibili/pages/home/VideoPlayPage.dart';
import 'package:flutter_MyBilibili/pages/home/video_play_page_with_danmaku.dart';
import 'package:flutter_MyBilibili/util/GetUtilBilibili.dart';
import 'package:flutter_MyBilibili/views/CardItemView.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RecommendPage extends StatefulWidget {
  const RecommendPage({Key key});
  @override
  _RecommendPageState createState() => _RecommendPageState();
}

class _RecommendPageState extends State<RecommendPage>
    with AutomaticKeepAliveClientMixin<RecommendPage> {
  _RecommendPageState({Key key});
  final List<VideoItem> listData = [];
  ScrollController _scrollController = ScrollController(); //listview的控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: true);
  bool isaddok = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      color: Colors.grey[200],
      child: buildCardList(),
    );
  }

  Widget buildCardList() {
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
            } else {
              body = Center(
                child: Text("正在加载"),
              );
            }
            return Container(
              height: 30,
              child: body,
            );
          },
        ),
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
           // buildBanners(),
            GridView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //控制主轴/纵轴之间空隙，列数，宽高比
                  mainAxisSpacing: 3.0,
                  crossAxisSpacing: 2.0,
                  crossAxisCount: 2,
                  childAspectRatio: 0.9),
              padding: EdgeInsets.all(5),
              itemCount: listData.length,
              itemBuilder: (BuildContext contex, int index) {
                return GestureDetector(
                  child: CardItemView(carditem: listData[index]),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (contex) =>
                                new VideoPlayPageWithDanmaku(listData[index].aid)));
                  },
                  onLongPress: () {
                    openUrl(listData[index].cover);
                  },
                );
              },
            ),
          ],
        ));
  }

  buildBanners() {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
        height: 160,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: GestureDetector(
            onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>VideoPlayPageWithDanmaku("69024725"))),
            child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("http://i0.hdslb.com/bfs/archive/75dbcd51ee22ff88b5529f767ee059bc980614d5.jpg"),fit: BoxFit.cover)
            ),
            child: Container(
            width: double.infinity,
            alignment: Alignment.bottomLeft,
            padding: EdgeInsets.only(top: 30, bottom: 10, left: 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color.fromRGBO(0, 0, 0, 0.01), Colors.black54]),
            ),
            child: Text(
              "弹幕测试",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
          ),
          ),
        ));
  }

  Future<Null> _onLoading() async {
    //print('onAddcard');
    listData.addAll(await GetUtilBilibili.getRecommend());
    _refreshController.loadComplete();
    if (mounted) setState(() {});
  }

  Future<Null> _onRefresh() async {
    listData.clear();
    listData.addAll(await GetUtilBilibili.getRecommend());
    _refreshController.refreshCompleted();
    if (mounted) setState(() {});
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

openUrl(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "no";
  }
}
