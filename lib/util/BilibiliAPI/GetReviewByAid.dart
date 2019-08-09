import 'dart:convert';
import 'dart:io';

import 'package:mytest/model/jsonmodel/ReviewItem.dart';
import 'package:mytest/model/jsonmodel/ReviewList_model.dart';

class GetReviewByAid{
  static  getReviewByAid(String aid,int page,) async{
    //51639674
    try{
      List<ReviewItem> reviewlist=[];
      HttpClient httpClient=new HttpClient();
      HttpClientRequest request=await httpClient.getUrl(
          //Uri.parse("http://api.bilibili.com/x/v2/reply?jsonp=jsonp&type=1&oid="+aid));
        Uri.parse("http://api.bilibili.com/x/reply?type=1&nohot=0&oid="+aid+"&pn=${page.toString()}"));

      HttpClientResponse response=await request.close();
      var result=await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata=json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      for(Map<String,dynamic> i in jsondata["data"]["hots"]){
        ReviewItem item=ReviewItem(i);
        reviewlist.add(item);
      }
      for(Map<String,dynamic> i in jsondata["data"]["replies"]){
        ReviewItem item=ReviewItem(i);
        reviewlist.add(item);
      }
      print("review listlen ${reviewlist.length}");
      httpClient.close();
      return reviewlist;
    }
    catch(e){
      print("请求失败");
      return  List<ReviewItem>();
    } finally{

    }

  }
  static  getHotReviewByAid(String aid) async{
    //51639674
    try{
      List<ReviewItem> reviewlist=[];
      HttpClient httpClient=new HttpClient();
      HttpClientRequest request=await httpClient.getUrl(
          //Uri.parse("http://api.bilibili.com/x/v2/reply?jsonp=jsonp&type=1&oid="+aid));
        Uri.parse("https://api.bilibili.com/x/reply?type=1&nohot=0&oid="+aid));

      HttpClientResponse response=await request.close();
      var result=await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata=json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      for(Map<String,dynamic> i in jsondata["data"]["hots"]){
        ReviewItem item=ReviewItem(i);
        reviewlist.add(item);
      }
      print("hot review listlen ${reviewlist.length}");
      httpClient.close();
      return reviewlist;
    }
    catch(e){
      print("请求失败");
      return List<ReviewItem>();
    } finally{

    }

  }
}