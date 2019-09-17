import 'dart:io';
import 'dart:convert';
import 'dart:math';

import 'package:flutter_MyBilibili/model/VideoItem.dart';
import 'package:flutter_MyBilibili/model/VideoItemFromJson.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/ChannelItem.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/GoodItem.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/ReviewList_model.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/hot_item.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/recommendlist_model.dart';
import "package:flutter_MyBilibili/model/jsonmodel/LiveItem.dart";

class GetUtilBilibili {
  static final String appkey = "c1b107428d337928";
  //appkey=1d8b6e7d45233436
  static void getweatherData() async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri.parse("https://t.weather.sojson.com/api/weather/city/101030100"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      print(result);
      httpClient.close();
    } catch (e) {
      print("请求失败");
    } finally {}
  }

  static getVideoDetailByAid(String aid) async {
    //51639674
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          Uri.parse("http://api.bilibili.cn/view?id=$aid&appkey=$appkey"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      VideoItemFromJson itemFromJson = VideoItemFromJson.fromJson(jsondata);
      //print(jsondata["pic"]);
      //print(itemFromJson.author);
      //print(itemFromJson.list[0].page);
      //print(itemFromJson.pages);
      //print(itemFromJson.pic);
      httpClient.close();
      return itemFromJson;
    } catch (e) {
      print("请求失败");
    } finally {}
  }

  static getRecommend() async {
    try {
      List<VideoItem> videolist = [];
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://app.bilibili.com/x/feed/index?appkey=1d8b6e7d45233436&build=508000&login_event=0&mobi_app=android"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      RecommendListModel recommendVideoListModel =
          RecommendListModel.fromJson(jsondata);
      print(recommendVideoListModel.data.length);
      if (recommendVideoListModel.data != null) {
        for (var item in recommendVideoListModel.data) {
          if (item.goto == "av") {
            //print("aid:"+item.param);
            videolist.add(VideoItem(
              title: item.title,
              cover: item.cover,
              time: durationtoString(item.duration),
              view: item.play > 10000
                  ? (item.play ~/ 10000).toString() + "万"
                  : item.play.toString(),
              aid: item.param,
              danmu: item.danmaku > 10000
                  ? (item.danmaku ~/ 10000).toString() + "万"
                  : item.danmaku.toString(),
              id: getrandomhash(),
              tname: item.tname,
            ));
          }
        }
      } else {
        print("error");
      }
      httpClient.close();
      return videolist;
    } catch (e) {
      print("请求失败");
      return List<VideoItem>();
    } finally {}
  }

  static durationtoString(int duration) {
    if (duration >= 3600) {
      return (duration ~/ 3600 < 10
              ? "0${duration ~/ 3600}"
              : "${duration ~/ 3600}") +
          ":" +
          ((duration ~/ 60) % 60 < 10
              ? "0${(duration ~/ 60) % 60}"
              : "${(duration ~/ 60) % 60}") +
          ":" +
          (duration % 60 < 10 ? "0${duration % 60}" : "${duration % 60}");
    } else {
      return ((duration ~/ 60) % 60 < 10
              ? "0${(duration ~/ 60) % 60}"
              : "${(duration ~/ 60) % 60}") +
          ":" +
          (duration % 60 < 10 ? "0${duration % 60}" : "${duration % 60}");
    }
  }

  static String getrandomhash() {
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 30;

    /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      // right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  static getRankList(String tid, String page) async {
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.bilibili.cn/list?appkey=c1b107428d337928&pagesize=10&tid=${tid}&page=${page}"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      RecommendListModel recommendVideoListModel =
          RecommendListModel.fromJson(jsondata);
      print(recommendVideoListModel.data.length);
      List<VideoItem> videolist = [];
      if (recommendVideoListModel.data != null) {
        for (var item in recommendVideoListModel.data) {
          if (item.goto == "av") {
            print("aid:" + item.param);
            videolist.add(VideoItem(
              title: item.title,
              cover: item.cover,
              time: durationtoString(item.duration),
              view: item.play > 10000
                  ? (item.play ~/ 10000).toString() + "万"
                  : item.play.toString(),
              aid: item.param,
              danmu: item.danmaku > 10000
                  ? (item.danmaku ~/ 10000).toString() + "万"
                  : item.danmaku.toString(),
              id: getrandomhash(),
              tname: item.tname,
            ));
          }
        }
      } else {
        print("error");
      }
      httpClient.close();
      return videolist;
    } catch (e) {
      print("请求失败");
    } finally {}
  }

  static getReviewByAid(String aid) async {
    //51639674
    try {
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.bilibili.com/x/v2/reply?jsonp=jsonp&type=1&oid=" + aid));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      ReviewList list = ReviewList.fromJson(jsondata);

      print("review get ok");
      httpClient.close();
      return list;
    } catch (e) {
      print("请求失败");
      return null;
    } finally {}
  }

  static getLivePartition() async {
    //获取推荐直播列表
    try {
      List<LivePartition> livelist = List<LivePartition>();
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.live.bilibili.com/room/v1/AppIndex/getAllList?device=android&platform=android&scale=xhdpi"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      //print(jsondata);
      for (Map<String, dynamic> p in jsondata["data"]["partitions"]) {
        livelist.add(LivePartition.fromJson(p));
      }
      print(livelist[0].lives[0].uname);
      print(livelist[0].lives[0].roomid);
      print("livelist get ok");
      httpClient.close();
      return livelist;
    } catch (e) {
      print("live请求失败");
      return List<LivePartition>();
      ;
    } finally {}
  }

  static getSearchByKeyword(String keyword, int pn,{String order="default"}) async {
    //获取搜索结果列表,pn为第几页,ps为页的大小
    try {
      List<VideoItem> searchresultlist = List<VideoItem>();
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://app.bilibili.com/x/v2/search?appkey=1d8b6e7d45233436&build=5370000&pn=${pn.toString()}&ps=15&keyword=$keyword&order=$order"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      for (Map<String, dynamic> item in jsondata["data"]["item"]) {
        if (item["linktype"] == "video") {
          //print(item["title"]);
          searchresultlist.add(VideoItem.fromSearchJson(item));
        }
      }
      print(searchresultlist.toString());
      //print("resultlistlen"+searchresultlist.length.toString());
      //print("search get ok");
      httpClient.close();
      return searchresultlist;
    } catch (e) {
      print("search请求失败");
      return List<VideoItem>();
    } finally {}
  }

  static getChannelList() async {
    //获取频道列表//因为需要sign这个参数，暂时还不会计算，所以就直接用现成的数据
    try {
      List<ChannelItem> channellist = List<ChannelItem>();

      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://app.bilibili.com/x/channel/square" +
              "?appkey=1d8b6e7d45233436&build=5370000&channel=huawei&login_event=1&mobi_app=android&platform=android&ts=1557534415&sign=1f43ef46c4bf2d4d738ab7af0f809b3d"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      //print(jsondata);
      for (Map<String, dynamic> item in jsondata["data"]["region"]) {
        channellist.add(ChannelItem.fromJson(item));
      }
      //print("resultlistlen"+searchresultlist.length.toString());
      //print("search get ok");
      httpClient.close();

      return channellist;
    } catch (e) {
      print("search请求失败");
      return List<ChannelItem>();
    } finally {}
  }

  static getMallList() async {
    //获取获取会员购列表
    try {
      List<GoodItem> goodllist = List<GoodItem>();
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://mall.bilibili.com/mall-c/home/index/v2?mVersion=17"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      //print("rpid "+jsondata["data"]["replies"][0]["rpid"].toString());
      //print(jsondata);
      for (Map<String, dynamic> item in jsondata["data"]["vo"]["feeds"]
          ["list"]) {
        //print(item);
        if (item["type"] == "ticketproject" || item["type"] == "mallitems") {
          goodllist.add(GoodItem.fromJson(item));
        }
      }
      //print("resultlistlen"+searchresultlist.length.toString());
      print("goods get ok");
      httpClient.close();
      return goodllist;
    } catch (e) {
      print("goods请求失败");
      return List<GoodItem>();
    } finally {}
  }

  static getHotSearchlList() async {
    //获取获取热搜列表列表
    try {
      List<String> hotSearchlList = List<String>();
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://app.bilibili.com/x/v2/search/hot?build=5370000&limit=10"));
      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      for (Map<String, dynamic> item in jsondata["data"]["list"]) {
          hotSearchlList.add(item["keyword"]);
      }
      print("hot search get ok");
      httpClient.close();
      return hotSearchlList;
    } catch (e) {
      print("hot search get error");
      return List<String>();
    } finally {}
  }

}
