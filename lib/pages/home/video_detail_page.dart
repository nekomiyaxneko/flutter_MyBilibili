import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/video_detail_item.dart';
import 'package:flutter_MyBilibili/tools/MyMath.dart';
import 'package:flutter_MyBilibili/tools/time_to_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoDetailItem videoDetailItem;
  final String aid;
  final int page;
  final Function onTapPage;
  VideoDetailPage(this.videoDetailItem, this.aid,{this.page=0,this.onTapPage});
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  String aid;
  int get page => widget.page;

  @override
  void initState() {
    aid = widget.aid;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ListView(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Container(
                //头像
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.videoDetailItem.data.owner.face)),
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
                    Text(
                      widget.videoDetailItem.data.owner.name,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${MyMath.intToString(widget.videoDetailItem.data.ownerExt.fans)}粉丝",
                      style: TextStyle(color: Colors.grey, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 75,
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: FlatButton(
                    onPressed: () {},
                    child: Text("+ 关注", style: TextStyle(color: Colors.white)),
                    color: Colors.pink[300],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Text(
              "${widget.videoDetailItem.data.title}",
              style: TextStyle(fontSize: 18),
              maxLines: 2,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Text(
                "播放 ${MyMath.intToString(widget.videoDetailItem.data.stat.view)}",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              Text(
                "  弹幕 ${MyMath.intToString(widget.videoDetailItem.data.stat.danmaku)}",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              Text(
                "  ${TimeToString.timeToString(DateTime.fromMillisecondsSinceEpoch(widget.videoDetailItem.data.ctime*1000))} ",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              GestureDetector(
                onLongPress: () {
                  Clipboard.setData(ClipboardData(text: "AV${widget.aid}"));
                  Fluttertoast.showToast(msg: "已复制av号到粘贴板");
                },
                child: Text(
                  "  AV${widget.aid}",
                  style: TextStyle(color: Colors.pink[300], fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Offstage(
            offstage: widget.videoDetailItem.data.pages.length<=1,
            child: 
          Container(
            height: 50,
            child: ListView(
            padding: EdgeInsets.only(bottom: 10),
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: widget.videoDetailItem.data.pages.map((Pages pages){
              return Container(
                width: 120,
                margin: EdgeInsets.only(right: 5,left: 5),
                child: OutlineButton(
                  child: Text(pages.part,maxLines: 1,overflow: TextOverflow.ellipsis,),
                  textColor: pages.page-1==page?Colors.pink[300]:Colors.black,
                  borderSide: BorderSide(
                    color: pages.page-1==page?Colors.pink[300]:Colors.grey[400],
                    width: 1,
                  ),
                  onPressed: (){
                    widget?.onTapPage(pages.page-1);
                  },
              ),
              );
            }).toList(),
          ),
          ),
          ),
          
          Text(
            widget.videoDetailItem.data.desc,
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: GestureDetector(
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        BIcon.zan,
                        color: Colors.grey[600],
                      ),
                      Text(
                        "${MyMath.intToString(widget.videoDetailItem.data.stat.like)}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  //喜欢
                },
              )),
              Expanded(
                  child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        BIcon.cai,
                        color: Colors.grey[600],
                      ),
                      Text(
                        "不喜欢",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  //不喜欢
                },
              )),
              Expanded(
                  child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        BIcon.icon,
                        color: Colors.grey[600],
                      ),
                      Text(
                        "${MyMath.intToString(widget.videoDetailItem.data.stat.coin)}",
                        style: TextStyle(color: Colors.grey, fontSize: 10),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  //投币
                },
              )),
              Expanded(
                  child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        BIcon.collection,
                        color: Colors.grey[600],
                      ),
                      Text("${MyMath.intToString(widget.videoDetailItem.data.stat.favorite)}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                    ],
                  ),
                ),
                onPressed: () {
                  //收藏
                },
              )),
              Expanded(
                  child: FlatButton(
                child: Padding(
                  padding: EdgeInsets.only(top: 7, bottom: 7),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        BIcon.share,
                        color: Colors.grey[600],
                      ),
                      Text("${MyMath.intToString(widget.videoDetailItem.data.stat.share)}",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                    ],
                  ),
                ),
                onPressed: () {
                  //分享
                  Share.share("https://www.bilibili.com/video/av$aid");
                },
              )),
            ],
          ),
        ],
      ),
    );
  }


  openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "no";
    }
  }
}
