import 'package:mytest/tools/MyMath.dart';

class Banner{
  String pic;
  int id;
  int postition;
  String title;
  String link;
  Banner({this.id,this.link,this.pic,this.postition,this.title});
  Banner.fromJson(Map<String ,dynamic> jsondata){
    pic=jsondata["pic"];
    id=jsondata["id"];
    postition=jsondata["postition"];
    title=jsondata["title"];
    link=jsondata["link"];
  }
}
class LivePartition{
  int id;
  String name;
  String icon;
  List<LiveItem> lives=[];
  LivePartition.fromJson(Map<String,dynamic> jsondata){
    id=jsondata["partition"]["id"];
    name=jsondata["partition"]["name"];
    icon=jsondata["partition"]["sub_icon"]["icon"];
    for(Map<String,dynamic> i in jsondata["lives"]){
      lives.add(LiveItem.fromJson(i));
    }
  }
}
class LiveItem{
  String id;
  int roomid;
  int uid;
  String title;
  String uname;
  String user_cover;
  String system_cover;
  String face;
  String area_name;
  String parent_name;
  int online;
  LiveItem({this.roomid,this.uid,this.title,this.uname,this.user_cover,this.area_name,this.face,this.online,this.parent_name,this.system_cover,});
  LiveItem.fromJson(Map<String ,dynamic> jsondata){
    roomid=jsondata["roomid"];
    uid=jsondata["uid"];
    title=jsondata["title"];
    uname=jsondata["uname"];
    user_cover=jsondata["user_cover"];
    system_cover=jsondata["system_cover"];
    face=jsondata["face"];
    area_name=jsondata["area_name"];
    parent_name=jsondata["parent_name"];
    online=jsondata["online"];
    id=MyMath.getrandomhash();
  }
}