import 'dart:convert';
import 'dart:io';

import 'package:flutter_MyBilibili/model/jsonmodel/ReviewItem.dart';

class GetReviewByAid {
  static getReviewByAid(
    String aid,
    {
    String next = "",
  }) async {
    //51639674
    try {
      List<ReviewItem> reviewlist = [];
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(
          //Uri.parse("http://api.bilibili.com/x/v2/reply?jsonp=jsonp&type=1&oid="+aid));
          Uri.parse(
              "https://api.bilibili.com/x/v2/reply/main?appkey=1d8b6e7d45233436&build=5370000&mobi_app=android&type=1&next=$next&oid=" +
                  aid));

      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      if (jsondata["data"]["replies"] != null) {
        for (Map<String, dynamic> i in jsondata["data"]["replies"]) {
          ReviewItem item = ReviewItem(i);
          reviewlist.add(item);
        }
      }
      print("review listlen ${reviewlist.length}");
      httpClient.close();
      return reviewlist;
    } catch (e) {
      print("请求失败");
      return null;
    } finally {}
  }

  static getHotReviewByAid(String aid) async {
    //51639674
    try {
      List<ReviewItem> reviewlist = [];
      HttpClient httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.getUrl(Uri.parse(
          "https://api.bilibili.com/x/v2/reply/main?appkey=1d8b6e7d45233436&build=5370000&mobi_app=android&type=1&oid=" +
              aid));

      HttpClientResponse response = await request.close();
      var result = await response.transform(utf8.decoder).join();
      Map<String, dynamic> jsondata = json.decode(result);
      if (jsondata["data"]["hots"] != null) {
        for (Map<String, dynamic> i in jsondata["data"]["hots"]) {
          ReviewItem item = ReviewItem(i);
          reviewlist.add(item);
        }
      }

      httpClient.close();
      return reviewlist;
    } catch (e) {
      print("请求失败");
      return null;
    } finally {}
  }
}
