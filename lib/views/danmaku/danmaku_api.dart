import 'package:dio/dio.dart';

class DanmakuApi{
  static getDanmakuByUrl(String url) async{
    String yesUrl="http://lllinux.hkg03.bdysite.com/bilibili/danmaku/getDanmaku.php?url="+url;
    Dio dio=Dio();
    try{
      Response res=await dio.get(yesUrl,options: Options(
        contentType: "text/xml",
        sendTimeout: 5000,
        receiveTimeout: 5000
      ));
      return res.data;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}