import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/model/VideoItem.dart';
import 'package:flutter_MyBilibili/model/VideoItemFromJson.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoItemFromJson videoItemFromJson;
  final VideoItem videoitem;
  VideoDetailPage(this.videoItemFromJson, this.videoitem);
  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10),
      child: ListView(
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
                      image: NetworkImage(widget.videoItemFromJson.face)),
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
                      widget.videoItemFromJson.author,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      "${widget.videoItemFromJson.credit}粉丝",
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
              "${widget.videoItemFromJson.title}",
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
                "播放 ${widget.videoitem.view}",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              Text(
                "  弹幕 ${widget.videoitem.danmu}",
                style: TextStyle(color: Colors.grey[600], fontSize: 12),
              ),
              GestureDetector(
                onTap: () {
                  openUrl(
                      "https://www.bilibili.com/video/av${widget.videoitem.aid}");
                },
                child: Text(
                  "  AV${widget.videoitem.aid}",
                  style: TextStyle(color: Colors.pink[300], fontSize: 12),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            widget.videoItemFromJson.description,
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
                        Icons.thumb_up,
                        color: Colors.grey[600],
                      ),
                      Text(
                        "喜欢",
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
                        Icons.thumb_down,
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
                      Container(
                        width: 23,
                        height: 23,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[600],
                        ),
                        child: Center(
                          child: Text(
                            "币",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        "${widget.videoItemFromJson.coins.toString()}",
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
                        Icons.star,
                        color: Colors.grey[600],
                      ),
                      Text("${widget.videoItemFromJson.favorites.toString()}",
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
                        Icons.share,
                        color: Colors.grey[600],
                      ),
                      Text("分享",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                          )),
                    ],
                  ),
                ),
                onPressed: () {
                  //分享
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
