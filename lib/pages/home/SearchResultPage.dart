import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/model/VideoItem.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';
import 'package:flutter_MyBilibili/util/GetUtilBilibili.dart';
import 'package:flutter_MyBilibili/pages/home/VideoPlayPage.dart';

class SearchResultPage extends StatefulWidget {
  SearchResultPage(this.keyword);
  final String keyword;
  @override
  _SearchResultPageState createState() => _SearchResultPageState();
}

class _SearchResultPageState extends State<SearchResultPage> {
  //TextEditingController keywordcontroller;//搜索栏控制
  String keyword; //初始关键字
  List<VideoItem> videoresullist = []; //视频结果集合
  SearchController _searchController = SearchController();
  String _searchOrder = "default";
  Map<String, String> _searchOrderList = {
    "default": "默认排序",
    "view": "播放多",
    "danmaku": "弹幕多",
    "pubdate": "新发布",
  };
  int pn = 1;
  @override
  void initState() {
    keyword = widget.keyword;
    super.initState();
    getSearchResult();
  }

  void getMoreResult() async {
    pn++;
    videoresullist.addAll(await GetUtilBilibili.getSearchByKeyword(keyword, pn,
        order: _searchOrder));
    if (this.mounted) {
      setState(() {});
    }
  }

  void getSearchResult() async {
    setState(() {
      videoresullist.clear();
      pn = 1;
      _searchController.status = SearchController.loading;
    });
    videoresullist.addAll(await GetUtilBilibili.getSearchByKeyword(keyword, pn,
        order: _searchOrder));
    print("getresult end");
    if (videoresullist.length > 0) {
      _searchController.status = SearchController.success;
    } else {
      _searchController.status = SearchController.error;
    }
    if (this.mounted) {
      setState(() {});
    }
    print("status${_searchController.status}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.all(8),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: TextField(
              controller: TextEditingController.fromValue(TextEditingValue(
                text: keyword,
                selection: TextSelection.fromPosition(
                  //保持光标在最后面
                  TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: keyword.length,
                  ),
                ),
              )), //提前设置数据
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  IconData(0xe669, fontFamily: "Bilibili"),
                  color: Colors.grey,
                ),
                hintText: "搜索视频或av号",
                border: InputBorder.none,
              ),
              onSubmitted: (text) {
                //提交时候回调
                print("searchresultpage:submit");
                print(text);
                if (text != "") {
                  keyword = text;
                  getSearchResult();
                }
              },
              onChanged: (text) {
                //改变时回调
                print("searchresultpage:change");
                print(text);
              },
            ),
          ),
        ),
        actions: <Widget>[
          Center(
              child: Padding(
            padding: EdgeInsets.only(top: 10, right: 15, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "取消",
                style: TextStyle(fontSize: 18),
              ),
            ),
          )),
        ],
      ),
      body: buildSearchResult(),
    );
  }

  buildSearchResult() {
    //如果加载动作完毕
    if (_searchController.status == SearchController.error) {
      //加载失败了
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Image.asset(
                "images/img_tips_error_load_error.png",
              ),
            ),
            Text("加载失败了"),
          ],
        ),
      );
    } else if (_searchController.status == SearchController.loading) {
      return buildWaitpage();
    } else {
      return Column(
        children: <Widget>[
          Container(
              alignment: Alignment.center,
              height: 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    child: Text(_searchOrderList[_searchOrder]),
                    onTap: selectSearchOrder,
                  ),
                  Text("全部时长"),
                  Text("全部分区"),
                ],
              )),
          Container(
            color: Colors.grey[300],
            height: 0.5,
          ),
          Expanded(
            child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: videoresullist.length,
              itemBuilder: (contex, i) {
                if (i >= videoresullist.length - 1) {
                  getMoreResult();
                }
                return buildVideoTile(videoresullist[i]);
              },
            ),
          ),
        ],
      );
    }
  }

  buildWaitpage() {
    //显示正在加载
    return Center(
      child: Container(
        child: Text("正在搜索。。"),
      ),
    );
  }

  buildVideoTile(VideoItem item) {
    //单个结果
    return Container(
      height: 120,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              new MaterialPageRoute(
                  builder: (contex) => new VideoPlayPage(item.aid))); //打开视频
        },
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
                                item.cover + "@320w_320h",
                              ), //封面
                              fit: BoxFit.cover)),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        margin: EdgeInsets.fromLTRB(5, 3, 5, 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(3)),
                          color: Colors.black54,
                        ),
                        child: Text(
                          item.time,
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
                            style: TextStyle(fontSize: 14,),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                          SizedBox(
                            height: 20,
                          ),
                              Text(
                                item.author,
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                              Text(
                                "播放 ${item.view} 弹幕 ${item.danmu}",
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

  selectSearchOrder() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.all(0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _searchOrderList.keys.map((key) {
            return FlatButton(
              child: Text(_searchOrderList[key]),
              onPressed: () {
                setState(() {
                  _searchOrder = key;
                });
                getSearchResult();
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
        // actions: _searchOrderList.keys.map((key){
        //   return FlatButton(
        //     child: Text(_searchOrderList[key]),
        //     onPressed: (){
        //       setState(() {
        //       _searchOrder=key;
        //       });
        //       Navigator.pop(context);
        //     },
        //   );
        // }).toList(),
      ),
    );
  }
}

class SearchController {
  static int error = -1;
  static int success = 0;
  static int loading = 1;
  static int video = 0;
  static int live = 4;
  int status = loading;
  SearchController();
}
