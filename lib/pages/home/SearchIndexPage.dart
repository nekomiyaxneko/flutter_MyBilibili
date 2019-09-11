import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/pages/home/SearchResultPage.dart';
import 'package:flutter_MyBilibili/tools/LineTools.dart';

class SearchIndexPage extends StatefulWidget {
  @override
  _SearchIndexPageState createState() => _SearchIndexPageState();
}

class _SearchIndexPageState extends State<SearchIndexPage> {
  TextEditingController searchcontroller = TextEditingController();
  String keyword = "";
  List _searchRecommandList = ["建国70周年", "黄晓明", "苹果发布会", "女高中生虚度日常", "说好不哭"];
  List _historyList = ["五五开", "绝地求生", "我的世界", "ipad", "有一个超好的女朋友是怎样的体验"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.all(8),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          //搜索输入框
          child: TextField(
            controller: TextEditingController.fromValue(
              TextEditingValue(
                text: keyword,
                selection: TextSelection.fromPosition(
                  //保持光标在最后面
                  TextPosition(
                    affinity: TextAffinity.downstream,
                    offset: keyword.length,
                  ),
                ),
              ),
            ),
            textInputAction: TextInputAction.search, //键盘上显示搜索按钮
            autofocus: true, //自动获取焦点
            style: TextStyle(
              color: Colors.grey,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                IconData(0xe669, fontFamily: "Bilibili"),
                color: Colors.grey,
              ),
              hintText: "搜索",
              border: InputBorder.none,
              fillColor: Colors.white,
              isDense: false,
            ),
            onSubmitted: (text) {
              //提交时候回调
              if (text != "") {
                Navigator.push(
                  context,
                  new MaterialPageRoute(
                    builder: (contex) => new SearchResultPage(text),
                  ),
                );
              }
            },
            onChanged: (text) {
              keyword = text;
            },
          ),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(top: 10, right: 15, bottom: 10),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text(
                "取消",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text("大家都在搜"),
          ),
          DrawLine.GreyLine(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Wrap(
              spacing: 10,
              children: _searchRecommandList.map((title) {
                return FlatButton(
                  color: Colors.grey[200],
                  onPressed: () {
                    keyword = title;
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (contex) => new SearchResultPage(keyword),
                      ),
                    );
                  },
                  child: Text(title),
                );
              }).toList(),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            child: Text("搜索历史"),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 10, right: 10),
            child: Wrap(
              spacing: 10,
              children: _historyList.map((title) {
                return FlatButton(
                  color: Colors.grey[200],
                  onPressed: () {
                    keyword = title;
                    Navigator.push(
                      context,
                      new MaterialPageRoute(
                        builder: (contex) => new SearchResultPage(keyword),
                      ),
                    );
                  },
                  child: Text(title),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
