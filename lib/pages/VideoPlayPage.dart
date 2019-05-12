import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mytest/model/VideoItem.dart';
import 'package:mytest/model/VideoItemFromJson.dart';
import 'package:mytest/pages/HomeTabBar.dart';
import 'package:mytest/pages/HotGridViewPage.dart';
import 'package:mytest/pages/ReviewsPage.dart';
import 'package:mytest/tools/MyVideoPlayer.dart';
import 'package:mytest/util/GetUtilBilibili.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoPlayPage extends StatefulWidget {
  @override
  final VideoItem videoitem;
  VideoPlayPage({this.videoitem});
  _VideoPlayPageState createState() => _VideoPlayPageState(videoitem: videoitem);
}

class _VideoPlayPageState extends State<VideoPlayPage> {
  var _videoplayscaffoldkey = new GlobalKey<ScaffoldState>();//key的用法
  final VideoItem videoitem;//视频基本信息，av号封面
  VideoItemFromJson videoItemFromJson;//视频详细信息，介绍等
  bool getvideodetailisok=false;
  bool isclickcover=false;
  _VideoPlayPageState({this.videoitem});
  @override
  void initState() {
    // TODO: implement initState
    getDetail();
    super.initState();
  }
  void getDetail() async{
    videoItemFromJson=await GetUtilBilibili.getVideoDetailByAid(videoitem.aid);
    if(videoItemFromJson!=null){
      getvideodetailisok=true;
      print("getDetailok");
    }
    setState(() {

    });
  }
  void showSnackBar(String message) {
    var snackBar = SnackBar(content: Text(message));
    _videoplayscaffoldkey.currentState.showSnackBar(snackBar);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _videoplayscaffoldkey,
      body: Column(
        children: <Widget>[
          Hero(
            tag: "${videoitem.id}",
            child: buildCover(),
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[800]
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 5,bottom: 5,left: 10,right: 10),
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: TextField(
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 10,top: 7,right: 10),
                      hintText: "发个友善的弹幕见证当下",
                      hintStyle: TextStyle(color: Colors.grey[500],),
                      border: InputBorder.none,
                    ),
                  ),
              ),
            ),
          ),
          Expanded(
            child: getvideodetailisok?VideoTabPage(videoItemFromJson,videoitem):Center(child:Text("正在加载")),
          )
        ],
      )
    );
  }
  Widget buildCover(){
    if(isclickcover==false){
      return Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(image: NetworkImage(videoitem.cover),fit: BoxFit.cover),
        ),
        child: Center(
            child: GestureDetector(
                onTap: (){
                  //播放
                  isclickcover=true;
                  setState(() {
                  });
                },
                onLongPress: (){
                  openUrl(videoitem.cover);
                },
                child: Opacity(
                  opacity: 0.8,
                  child: Container(
                    height: 40,
                    width: 60,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                    child: Icon(Icons.play_arrow,color: Colors.white,size: 35,),
                  ),
                )
            )
        ),
      );
    }
    else{
      int i=Random().nextInt(2);
      print("i"+i.toString());
      if(i!=1){
        return Container(
          height: 220,
          child: MyVideoPlayer(url: "https://github.com/nekomiyaxneko/MyResouse/raw/master/butterfly.mp4",),
        );
      }
      else{
        return Container(
          height: 220,
          child: Image.asset("images/timg.gif",fit: BoxFit.contain,),
        );
      }
        
    }
  }
  _openUrl(String url){

  }
}

class VideoTabPage extends StatelessWidget {

  VideoItemFromJson videoItemFromJson;
  VideoItem videoitem;
  VideoTabPage(VideoItemFromJson videoItemFromJson,VideoItem videoitem){
    this.videoItemFromJson=videoItemFromJson;
    this.videoitem=videoitem;
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          child:   AppBar(
            titleSpacing: 0,
            elevation: 2,
            automaticallyImplyLeading: false,
            centerTitle:true,
            backgroundColor: Colors.white,
            title: TabBar(

                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.pinkAccent,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.pinkAccent,
                //isScrollable: true,//设置为可以滚动
                tabs: [
                  Text("简介"),
                  Text("评论${videoItemFromJson.review.toString()}"),
                ]
            ),
          ),
          preferredSize: Size.fromHeight(30),
        ),

        body: TabBarView(
          children: <Widget>[
            IntroducePage(),
            ReviewsPage(aid: videoitem.aid,),
          ],
        ),
      ),
    );
  }
  Widget IntroducePage(){
    return Padding(
      padding: EdgeInsets.only(left: 10,right: 10),
      child: ListView(
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(//头像
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(image: NetworkImage(videoItemFromJson.face)),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(videoItemFromJson.author,style: TextStyle(fontSize: 14),),
                    SizedBox(height: 3,),
                    Text("${videoItemFromJson.credit}粉丝",style: TextStyle(color: Colors.grey,fontSize: 11),),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 75,
                child: Padding(
                  padding: EdgeInsets.only(top: 7,bottom: 7),
                  child: FlatButton(
                    onPressed: (){},
                    child: Text("+ 关注",style: TextStyle(color: Colors.white)),
                    color: Colors.pink[300],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15,),
          Container(
            child: Text(
              "${videoItemFromJson.title}",
              style: TextStyle(fontSize: 18),
              maxLines: 2,
            ),
          ),
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              Text("播放 ${videoitem.view}",style: TextStyle(color: Colors.grey[600],fontSize: 12),),
              Text("  弹幕 ${videoitem.danmu}",style: TextStyle(color: Colors.grey[600],fontSize: 12),),
              GestureDetector(
                onTap: (){
                  openUrl("https://www.bilibili.com/video/av${videoitem.aid}");
                },
                child: Text("  AV${videoitem.aid}",style: TextStyle(color: Colors.pink[300],fontSize: 12),),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(videoItemFromJson.description,style: TextStyle(color: Colors.grey),),
          SizedBox(height: 15,),
          Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.thumb_up,color: Colors.grey[600],),
                          Text("喜欢",style: TextStyle(color: Colors.grey,fontSize: 10),),
                        ],
                      ),
                    ),
                    onPressed: (){//喜欢

                    },
                  )
              ),
              Expanded(
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.thumb_down,color: Colors.grey[600],),
                          Text("不喜欢",style: TextStyle(color: Colors.grey,fontSize: 10),),
                        ],
                      ),
                    ),
                    onPressed: (){//不喜欢

                    },
                  )
              ),
              Expanded(
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.grey[600],
                            ),
                            child: Center(
                              child: Text("币",style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          SizedBox(height: 4,),
                          Text("${videoItemFromJson.coins.toString()}",style: TextStyle(color: Colors.grey,fontSize: 10),),
                        ],
                      ),
                    ),
                    onPressed: (){//投币

                    },
                  )
              ),
              Expanded(
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.star,color: Colors.grey[600],),
                          Text("${videoItemFromJson.favorites.toString()}",style: TextStyle(color: Colors.grey,fontSize: 10,)),
                        ],
                      ),
                    ),
                    onPressed: (){//收藏

                    },
                  )
              ),
              Expanded(
                  child: FlatButton(
                    child: Padding(
                      padding: EdgeInsets.only(top: 7,bottom: 7),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.share,color: Colors.grey[600],),
                          Text("分享",style: TextStyle(color: Colors.grey,fontSize: 10,)),
                        ],
                      ),
                    ),
                    onPressed: (){//分享

                    },
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }


}
openUrl(String url) async{
  if(await canLaunch(url)){
    await launch(url);
  }
  else{
    throw "no";
  }
}


