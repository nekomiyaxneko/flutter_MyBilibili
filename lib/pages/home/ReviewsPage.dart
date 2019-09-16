import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/ReviewItem.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';
import 'package:flutter_MyBilibili/util/BilibiliAPI/GetReviewByAid.dart';

class ReviewsPage extends StatefulWidget {
  final String aid;
  ReviewsPage(this.aid);
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
    with AutomaticKeepAliveClientMixin<ReviewsPage> {
  List<ReviewItem> reviewList = [];
  //ReviewList reviewListfromjson;
  int pages = 0;
  int length = 0;
  bool isgetok = false;
  bool isloadfail = false; //假设没有加载失败
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // return Text("这个是评论列表"+aid);
    if (isloadfail == true) {
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
    } else if (isgetok == true&&reviewList.length>0) {
      return reviewListView();
    } 
    else if(isgetok==false){
      return Center(
        child: CircularProgressIndicator(),
      ); 
    }
    else {
      return Center(
        child: Text("再怎么找也没有啦"),
      );
    }
  }

  void getReviewList() async {
    //首次进入
    reviewList = await GetReviewByAid.getReviewByAid(widget.aid, 1);
    if(reviewList==null){
      isloadfail = true;
    }
    else {
      isgetok = true; //加载完毕
      if(mounted)setState(() {});
    }
  }

  Future<Null> _onRefresh() async {
    reviewList = await GetReviewByAid.getReviewByAid(widget.aid, 1);
    if(mounted) setState(() {});
  }

  Widget reviewListView() {
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        //physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: reviewList.length,
        itemBuilder: (context, i) {
          return reviewTile(reviewList[i]);
        },
      ),
    );
  }

  Widget reviewTile(ReviewItem review) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 45,
                child: ClipOval(
                  child: Image.network(
                    review.pic+"@100w_100h",
                    fit: BoxFit.cover,
                    ),
                )
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft,
                          margin: EdgeInsets.only(
                            right: 10,
                          ),
                          child: Text(
                            review.uname,
                            style: TextStyle(
                              color: review.vipStatus==1?Colors.pink:Colors.grey[700],
                            ),
                          ), //名字
                        ),
                        Icon(
                          BIcon.level[review.level],
                          color: BIcon.levelColor[review.level],
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "#" + review.floor.toString(),
                              style: TextStyle(color: Colors.grey[600]),
                            ), //楼层
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        review.message,
                        style: TextStyle(fontSize: 16),
                      ), //评论主体
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Icon(
                              BIcon.zan,
                              color: Colors.grey[500],
                              size: 14,
                            ),
                            Text(
                              "  " +
                                  (review.like == 0
                                      ? ""
                                      : review.like.toString()),
                              style: TextStyle(
                                  color: Colors.grey[500], fontSize: 12),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              BIcon.cai,
                              color: Colors.grey[500],
                              size: 14,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              BIcon.share,
                              color: Colors.grey[500],
                              size: 14,
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.more_vert,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        DrawLine.GreyLine(),
      ],
    );
  }
}
