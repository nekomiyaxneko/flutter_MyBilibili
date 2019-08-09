
import 'package:flutter/material.dart';
import 'package:mytest/model/jsonmodel/ReviewItem.dart';
import 'package:mytest/tools/LineTools.dart';
import 'package:mytest/util/BilibiliAPI/GetReviewByAid.dart';

class ReviewsPage extends StatefulWidget {
  final String aid;
  ReviewsPage(this.aid);
  @override
  _ReviewsPageState createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
    with AutomaticKeepAliveClientMixin<ReviewsPage>{
  List<ReviewItem> reviewList=[];
  //ReviewList reviewListfromjson;
  int pages=0;
  int length=0;
  bool isgetok=false;
  bool isloadfail=false;//假设没有加载失败
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getReviewList();
  }

  @override
  Widget build(BuildContext context) {
    // return Text("这个是评论列表"+aid);
    if(isloadfail==true){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 100,
              width: 100,
              child: Image.asset("images/img_tips_error_load_error.png",),
            ),
            Text("加载失败了"),
          ],
        ),
      );
    }
    else if(isgetok==true){
      //return ReviewListView();
      return reviewListView();

    }
    else{
      return Center(
        child: Text("加载中.."),
      );
    }

  }

  void getReviewList() async{//首次进入
    reviewList=await GetReviewByAid.getReviewByAid(widget.aid,1);
    //reviewListfromjson=await GetUtilBilibili.getReviewByAid(aid);
    //print(""+reviewList[0].message);
    //print("get over");
    if(reviewList.length!=0){
      isgetok=true;//加载完毕
    }
    else{
      isloadfail=true;
    }
    print("LOadlist");
    loadReviewList();

  }
  loadReviewList(){//加载
    pages=reviewList.length;
    /*
    if(pages+10>reviewList.length){
      pages+=reviewList.length%20;
    }
    else{
      pages+=10;
    }
    */
    setState(() {

    });

  }
  Future<Null> _onRefresh() async {
    reviewList=await GetReviewByAid.getReviewByAid(widget.aid,1);
    loadReviewList();
    setState(() {
    });
  }

  Widget reviewListView(){
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        //physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: pages,
        itemBuilder: (context,i){
          if(i>=pages){
            loadReviewList();
          }
          return reviewTile(reviewList[i]);
          //return Text("123");
        },
      ),
    );

  }
  Widget reviewTile(ReviewItem review){

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 45,
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                ),
                child: Container(
                  height: 35,
                  width: 35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(17),
                    image: DecorationImage(image: NetworkImage(review.pic)),//头像
                  ),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(review.uname,style: TextStyle(color: Colors.grey[700]),),//名字
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Text("#"+review.floor.toString(),style: TextStyle(color: Colors.grey[600]),),//楼层
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(review.message,style: TextStyle(fontSize: 16),),//评论主体
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.thumb_up,color: Colors.grey[500],size: 14,),
                              Text(" "+(review.like==0?"":review.like.toString()),style: TextStyle(color: Colors.grey[500],fontSize: 12),),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.thumb_down,color: Colors.grey[500],size: 14,),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.share,color: Colors.grey[500],size: 14,),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.centerRight,
                            child:Icon(Icons.more_vert,color: Colors.grey[500],size: 18,),
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
