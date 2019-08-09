import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mytest/model/VideoItem.dart';
import 'package:mytest/pages/VideoPlayPage.dart';

class CardItemView extends StatelessWidget {
  final VideoItem carditem;
  CardItemView({this.carditem});
  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))
      ),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Hero(
              tag: "${carditem.id}",
              child: Container(
                //height: 120.0,
                decoration: BoxDecoration(//封面图
                  image: DecorationImage(
                      image: NetworkImage(carditem.cover+"@320w_200h.jpg"),
                      fit: BoxFit.fitHeight
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.0),
                    topRight: Radius.circular(5.0),
                  ),
                ),

                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(2),
                  //constraints: BoxConstraints.,
                  decoration: BoxDecoration(
                    color: Colors.black38
                  ),
                  //padding: EdgeInsets.only(left: 3,right: 3,bottom: 0),
                  child: Text("播放 "+carditem.view+" 弹幕 "+carditem.danmu+" "+carditem.time,
                    style: TextStyle(color: Colors.white,fontSize: 12),
                    maxLines: 1,
                    )
                  
                )
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5,left: 5,right: 5),
                  child: Text(carditem.title,style: TextStyle(color: Colors.black,fontSize: 14),maxLines: 2,),
                ),
              )
          ),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 0,left: 5,right: 5,bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text("${carditem.tname}",style: TextStyle(color: Colors.grey,fontSize: 13),),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.centerRight,
                        child: Icon(Icons.more_vert,size: 13,color: Colors.grey,),
                      ),
                    )
                  ],
                ),
              )
          )

        ],
      ),
    );
  }
}
