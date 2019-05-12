
import 'package:flutter/material.dart';
import 'package:mytest/pages/SearchResultPage.dart';
import 'package:mytest/tools/LineTools.dart';
class SearchIndexPage extends StatefulWidget {
  @override
  _SearchIndexPageState createState() => _SearchIndexPageState();
}

class _SearchIndexPageState extends State<SearchIndexPage> {
  TextEditingController searchcontroller;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:false,
        title: Padding(
          padding: EdgeInsets.all(9),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            child: TextField(//搜索输入框
              maxLength: 20,
              textInputAction: TextInputAction.search,//键盘上显示搜索按钮
              autofocus: true,//自动获取焦点
              style: TextStyle(color: Colors.grey),
              decoration: InputDecoration(
                prefixIcon:Icon(Icons.search,color: Colors.grey,),
                hintText: "搜索",
                border: InputBorder.none,
              ),
              onSubmitted: ( text){//提交时候回调
                if(text!=""){
                  print("searchindexpage:");
                  print(text);
                  Navigator.push(context, new MaterialPageRoute(builder: (contex)=> new SearchResultPage(text)));
                }
                
              },
              onChanged: (text){//改变时回调
                print("searchindexpage:");
                print(text);
              },
            ),
          ),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 10,right: 15,bottom: 10),
              child: GestureDetector(
                onTap: (){Navigator.pop(context);},
                child: Text("取消",style: TextStyle(fontSize: 18),),
              ),
            )
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: Text("大家都在搜"),
            ),            
          ),
          DrawLine.GreyLine(),
          Padding(
            padding: EdgeInsets.only(left: 5,right: 5,top: 5),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("我只喜欢你",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("蔡旭坤",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("我们无法一起学习",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),

              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 5,right: 5,top: 5),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("咬人猫",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("MSI",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("辉夜大小姐",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 5,bottom: 5,left: 5,right: 5),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top:10,bottom: 10,left: 15,right: 15),
                      child: Text("钢铁侠",style: TextStyle(color: Colors.black87),),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}