import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/icons/bilibili_icons.dart';
import 'package:flutter_MyBilibili/model/VideoItem.dart';

class CardItemView extends StatelessWidget {
  final VideoItem carditem;
  CardItemView({this.carditem});
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: new Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Hero(
              tag: "${carditem.id}",
              child: Container(
                  decoration: BoxDecoration(
                    //封面图
                    image: DecorationImage(
                        image: NetworkImage(carditem.cover + "@320w_200h.jpg"),
                        fit: BoxFit.fitHeight),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5.0),
                      topRight: Radius.circular(5.0),
                    ),
                  ),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        top: 30, bottom: 2, left: 10, right: 10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromRGBO(0, 0, 0, 0.01),
                            Colors.black54
                          ]),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              BIcon.play,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text(
                              "${carditem.view}   ",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                              textAlign: TextAlign.justify,
                            ),
                            Icon(
                              BIcon.danmaku,
                              color: Colors.white,
                              size: 15,
                            ),
                            Text("${carditem.danmu}",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                                textAlign: TextAlign.justify),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            "${carditem.time}",
                            textAlign: TextAlign.right,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    // Text("播放 "+carditem.view+" 弹幕 "+carditem.danmu+" "+carditem.time,
                    //   style: TextStyle(color: Colors.white,fontSize: 12),
                    //   maxLines: 1,
                    //   )
                  )),
            ),
          ),
          Expanded(
              flex: 2,
              child: Container(
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 5, right: 5),
                  child: Text(
                    carditem.title,
                    style: TextStyle(color: Colors.black, fontSize: 14),
                    maxLines: 2,
                  ),
                ),
              )),
          Expanded(
              flex: 1,
              child: Padding(
                padding: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${carditem.tname}",
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.centerRight,
                        child: Icon(
                          Icons.more_vert,
                          size: 13,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
