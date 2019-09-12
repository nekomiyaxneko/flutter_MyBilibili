import 'dart:convert';

import 'package:flutter_MyBilibili/util/storage.dart';

class SearchServices{
  static const String hotkey="hotSearchList";
  //插入新的记录
  static setHistoryData(String keyword)async{
    try{
      List searchList=json.decode(await Storage.getString(hotkey));
      bool hasData=searchList.any((v){return v==keyword;});
      print("hasData"+hasData.toString());
      if(!hasData){
        searchList.insert(0,keyword);
      }
      else{
        searchList.remove(keyword);
        searchList.insert(0,keyword);
      }
      //控制数量
      while(searchList.length>8){
        searchList.removeLast();
      }
      await Storage.setString(hotkey, json.encode(searchList));
    }catch(e){
      print(e.toString());
      List temp=List<String>();
      temp.add(keyword);
      print("temp"+json.encode(temp));
      await Storage.setString(hotkey, json.encode(temp));
      List list=json.decode(await Storage.getString(hotkey));
      print("temp2"+list.toString());
    }
  }
  //获取记录列表
  static getHistoryList()async{
    try{
      List searchList=json.decode(await Storage.getString(hotkey));
      return searchList;
    }catch(e){
      return List();
    }
  }
  //删除所有记录
  static removeHistory()async{
    await Storage.remove(hotkey);
  }
}