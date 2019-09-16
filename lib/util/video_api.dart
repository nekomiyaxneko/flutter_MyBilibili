import 'dart:convert';

import 'package:dio/dio.dart';

class VideoApi{

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
}