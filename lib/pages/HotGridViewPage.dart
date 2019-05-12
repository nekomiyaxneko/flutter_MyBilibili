import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mytest/beans/ItemView.dart';
import 'package:mytest/model/VideoItem.dart';
import 'package:mytest/pages/VideoPlayPage.dart';
import 'package:mytest/util/GetUtilBilibili.dart';
import 'package:mytest/views/CardItemView.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';


class HotGridViewPage extends StatefulWidget {
  const HotGridViewPage({Key key,this.item});
   
  final HomeTabBarItemView item;
  @override
  _HotGridViewPageState createState() => _HotGridViewPageState(item: item);
}

class _HotGridViewPageState extends State<HotGridViewPage> 
  with AutomaticKeepAliveClientMixin<HotGridViewPage>{
  _HotGridViewPageState({Key key,this.item});
  final List<VideoItem> listData=[];
  final HomeTabBarItemView item;
  ScrollController _scrollController = ScrollController(); //listview的控制器
  bool isaddok=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addCard();
  }
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle=Theme.of(context).textTheme.display1;
    return buildCardList();
    
    
  }
  Widget buildCardList(){
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child:GridView.builder(
        controller: _scrollController,
        physics: AlwaysScrollableScrollPhysics(),
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(//控制主轴/纵轴之间空隙，列数，宽高比
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 5.0,
          crossAxisCount: 2,
          childAspectRatio: 0.9
        ),
        padding: EdgeInsets.all(5),
        itemCount: listData.length,
        itemBuilder: (BuildContext  contex,int index){
          //print("index $index");
          if(index>=listData.length-1){
            _onAddCard();
          }
          return GestureDetector(
            child:  CardItemView(carditem: listData[index]),
            onTap: (){
              Navigator.push(context, new MaterialPageRoute(builder: (contex)=> new VideoPlayPage(videoitem:listData[index])));
            },
            onLongPress: (){
              openUrl(listData[index].cover);
            },
          );

        },
      ),
    );
  }
  addCard() async{
    //print("in addcard");
    listData.addAll( await GetUtilBilibili.getRecommend());
    //print("addok");
    isaddok=true;
    setState(() {

    });
    //print("listlen: ${listData.length}");
  }
  Future<Null> _onAddCard() async {
      //print('onAddcard');
      listData.addAll( await GetUtilBilibili.getRecommend());
      setState(() {
      });
  }

  Future<Null> _onRefresh() async {
    listData.clear();
    listData.addAll( await GetUtilBilibili.getRecommend());
    setState(() {
    });
  }
/*
  void _onImageSaveButtonPressed(String url) async {
    print("_onImageSaveButtonPressed");
    var response = await http
    //.get('http://upload.art.ifeng.com/2017/0425/1493105660290.jpg');
        .get(url);

    debugPrint(response.statusCode.toString());

    var filePath = await ImagePickerSaver.saveFile(
        fileData: response.bodyBytes);

    var savedFile= File.fromUri(Uri.file(filePath));
    print(savedFile.toString());
    setState(() {
      //_imageFile = Future<File>.sync(() => savedFile);
      });
  }
  */


  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
openUrl(String url) async{
  if(await canLaunch(url)){
    await launch(url);
  }
  else{
    throw "no";
  }
}


