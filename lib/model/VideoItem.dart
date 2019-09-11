import 'package:flutter_MyBilibili/tools/MyMath.dart';

class VideoItem{
  VideoItem({this.danmu,this.cover,this.msg,this.title,this.time,this.view,this.id,this.aid,this.tname,this.desc});
  String title;
  String time;
  String view;
  String danmu;
  String msg;
  String cover;
  String id;
  String aid;
  String tname;
  String desc;
  String author;
  VideoItem.fromSearchJson(Map<String ,dynamic> jsondata){
    if(jsondata["play"]!=null){//返回数据中可能没有play，要手动改为 0
      int tplay=jsondata["play"];
      view=tplay>10000?(tplay~/10000).toString()+"万":tplay.toString();
    } else{
      view="--";
    }
    if(jsondata["danmaku"]!=null){//返回数据中可能没有danmaku，要手动改为 0
      int tdanmu=jsondata["danmaku"];
      danmu=tdanmu>10000?(tdanmu~/10000).toString()+"万":tdanmu.toString();
    } else{
      danmu="--";
    }
    title=jsondata["title"];
    time=jsondata["duration"];
    cover="http:"+jsondata["cover"];
    author=jsondata["author"];
    desc=jsondata["desc"];
    id=MyMath.getrandomhash();
    aid=jsondata["param"];
    
  }
}