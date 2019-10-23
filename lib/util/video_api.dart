import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter_MyBilibili/model/video_detail_item.dart';

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
  static getVideoPlayUrlV2(int cid,{int qn=64})async{
    String appserct="aHRmhWMLkdeMuILqORnYZocwMBpMEOdt";
    String path="https://app.bilibili.com/playurl";
    String data="appkey=iVGUTjsxvpLeuDCf&build=500001&buvid=C0928256-085D-4722-A38F-2E343710C8B3155817infoc&cid=$cid&device=android&otype=json&platform=android&qn=$qn";
    String sign=md5.convert(utf8.encode(data+appserct)).toString();
    String url="$path?$data&sign=$sign";
    Dio dio=Dio();
    try{
      Response res=await dio.get(url,
      options: Options(
        responseType: ResponseType.json
      ));
      if(res.data["durl"][0]["url"]!=null){
        return res.data["durl"][0]["url"];
      }
      return null;
    }
    catch(e){
      print(e.toString());
      print("获取视频播放地址失败");
      return null;
    }
  }

  static getVideoPlayUrlV3(String aid,int cid,{int qn=64})async{
    String appserct="aHRmhWMLkdeMuILqORnYZocwMBpMEOdt";
    String path="https://app.bilibili.com/x/playurl";
    int ts=DateTime.now().millisecondsSinceEpoch;
    String data="actionkey=appkey&aid=$aid&appkey=iVGUTjsxvpLeuDCf&build=5490400&buvid=XZF9F55FE566C57599024A397F5F160E74DBE&cid=$cid&device=android&expire=0&fnval=16&fnver=0&force_host=0&fourk=0&from_spmid=tm.recommend.0.0&mid=0&mobi_app=android&otype=json&platform=android&qn=$qn&spmid=main.ugc-video-detail.0.0&ts=$ts";
    String sign=md5.convert(utf8.encode(data+appserct)).toString();
    String url="$path?$data&sign=$sign";
    Dio dio=Dio();
    try{
      Response res=await dio.get(url,
      options: Options(
        responseType: ResponseType.json
      ));
      if(res.data["data"]["dash"]!=null){
        String vl;
        for(Map<String,dynamic> jd in res.data["data"]["dash"]["video"]){
          if(jd["id"]==qn){
            vl=jd["base_url"];
            break;
          }
        }
        vl=vl??res.data["data"]["dash"]["video"][0]["base_url"];

        String al=res.data["data"]["dash"]["audio"][0]["base_url"];
        return {"video_url":vl,"audio_url":al};
      }
      else if(res.data["data"]["durl"]!=null){
        String vl=res.data["data"]["durl"][0]["url"];
        return {"video_url":vl,"audio_url":null};
      }
      return null;
    }
    catch(e){
      print(e.toString());
      print("获取视频播放地址失败");
      return null;
    }
  }

  static getVideoDetail(String aid)async{
    String appserct="560c52ccd288fed045859ed18bffd973";
    String path="https://app.bilibili.com/x/v2/view";
    String data="aid=$aid&appkey=1d8b6e7d45233436&build=5480400&ts=${DateTime.now().millisecondsSinceEpoch}";
    String sign=md5.convert(utf8.encode(data+appserct)).toString();
    String url="$path?$data&sign=$sign";
    Dio dio=Dio();
    try{
      Response res=await dio.get(url,options: Options(
        sendTimeout: 5000
      ));
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