import 'package:dio/dio.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/LiveItem.dart';
import 'package:flutter_MyBilibili/pages/home/live_play_page.dart';

class LiveApi {
  static Future getLivePlayUrl(String roomid) async {
    String url =
        "https://api.live.bilibili.com/room/v1/Room/playUrl?build=5470400&device=android&cid=$roomid";
    Dio dio = Dio();
    try {
      Response res = await dio.get(url,
          options: Options(
            receiveTimeout: 5000,
            sendTimeout: 5000,
          ));

      if (res.data["data"]["durl"] != null) {
        List<String> list = [];
        for (Map<String, dynamic> i in res.data["data"]["durl"]) {
          if (i != null && i["url"] != null) {
            list.add(i["url"]);
          }
        }
        return list;
      }
      return null;
    } catch (e) {
      print(e.toString());
      print("获取播放列表失败");
      return null;
    }
  }

  static getLiveList() async {
    List livelist = List();
    try {
      Dio dio = Dio();
      String url =
          "https://api.live.bilibili.com/room/v1/AppIndex/getAllList?device=android&platform=android&scale=xhdpi";
      Response res = await dio.get(url,
          options: Options(
            receiveTimeout: 5000,
            sendTimeout: 5000,
          ));
      //TODO 去除固定数据
      AreaCard areaCard = AreaCard([
        AreaItem(
          "http://i0.hdslb.com/bfs/vc/dcfb14f14ec83e503147a262e7607858b05d7ac0.png",
          "英雄联盟",
        ),
        AreaItem(
          "http://i0.hdslb.com/bfs/vc/c666c6dc2d5346e0d3cfda7162914d84d16964dd.png",
          "lol云顶之弈",
        ),
        AreaItem(
          "http://i0.hdslb.com/bfs/vc/8f7134aa4942b544c4630be3e042f013cc778ea2.png",
          "王者荣耀",
        ),
        AreaItem(
            "http://i0.hdslb.com/bfs/live/8fd5339dac84ec34e72f707f4c3b665d0aa41905.png",
            "娱乐"),
        AreaItem(
            "http://i0.hdslb.com/bfs/live/827033eb0ac50db3d9f849abe8e39a5d3b1ecd53.png",
            "单机"),
        AreaItem(
            "http://i0.hdslb.com/bfs/live/a7adae1f7571a97f51d60f685823acc610d00a7e.png",
            "电台"),
        AreaItem(
            "http://i0.hdslb.com/bfs/vc/9bfde767eae7769bcaf9156d3a7c4df86632bd03.png",
            "怪物猎人:世界"),
        AreaItem(
            "http://i0.hdslb.com/bfs/vc/973d2fe12c771207d49f6dff1440f73d153aa2b2.png",
            "无主之地3"),
        AreaItem(
            "http://i0.hdslb.com/bfs/vc/976be38da68267cab88f92f0ed78e057995798d6.png",
            "第五人格"),
        AreaItem(
            "https://i0.hdslb.com/bfs/vc/ff03528785fc8c91491d79e440398484811d6d87.png",
            "全部标签"),
      ]);
      Banners temp = Banners.fromJson(res.data["data"]);
      livelist.add(temp);
      livelist.add(areaCard);
      for (Map<String, dynamic> p in res.data["data"]["partitions"]) {
        livelist.add(LivePartition.fromJson(p));
      }
      return livelist;
    } catch (e) {
      print(e.toString());
      return livelist;
    }
  }

  static getLiveInfo(String roomid)async {
    try {
      Dio dio = Dio();
      String url =
          "https://api.live.bilibili.com/room/v1/Room/get_info?id=$roomid";
      Response res = await dio.get(
        url,
        options: Options(
          receiveTimeout: 5000,
          sendTimeout: 5000,
        ),
      );
      print(res.data);
      if(res.data["code"]==0){
        return LiveInfo.fromJson(res.data["data"]);
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
