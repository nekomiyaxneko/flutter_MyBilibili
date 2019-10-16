import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_MyBilibili/model/video_detail_item.dart';

class VideoApi{
  static String appserct="560c52ccd288fed045859ed18bffd973";
  static getVideoPlayUrl(String aid,{int page=1})async{
    String url="http://api.bilibili.com/playurl?aid=$aid&platform=html5&quality=3&vtype=mp4&type=jsonp&page=$page";
    Dio dio=Dio();
    try{
      Response res=await dio.get(url,options: Options(
        headers: {"Cookie":"buvid3=5410244B-513B-4AB8-98AC-0B6F466E36A3190966infoc"}
      ));
      
      if(res.data["durl"]["0"]["url"]!=null){
        return res.data["durl"]["0"]["url"];
      }
      return null;
    }
    catch(e){
      print(e.toString());
      print("获取播放列表失败");
      return null;
    }

  }
  static getVideoDetail(String aid)async{
    String path="https://app.bilibili.com/x/v2/view";
    String data="aid=$aid&appkey=1d8b6e7d45233436&build=5480400&ts=${DateTime.now().millisecondsSinceEpoch}";
    String sign=md5.convert(utf8.encode(data+appserct)).toString();
    String url="$path?$data&sign=$sign";
    Dio dio=Dio();
    try{
      Response res=await dio.get(url,options: Options(
        sendTimeout: 5000
      ));
      print(res.data);
      if(res.data["code"]==0){
        VideoDetailItem videoDetailItem=VideoDetailItem.fromJson(res.data);
        return videoDetailItem;
      }
      return res.data["code"];
    }
    catch(e){
      print(e.toString());
      print("获取视频详情");
      return null;
    }

  }
}