import 'package:dio/dio.dart';

class DanmakuApi{
  static getDanmakuByUrl(String url) async{
    String yesUrl="http://lllinux.hkg03.bdysite.com/bilibili/danmaku/119644213.xml";
    Dio dio=Dio();
    try{
      Response res=await dio.get(yesUrl,options: Options(
        contentType: "text/xml",
      ));
      return res.data;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}