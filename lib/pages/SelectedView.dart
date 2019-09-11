import 'package:flutter/material.dart';
import 'package:flutter_MyBilibili/beans/ItemView.dart';

class SelectedView extends StatefulWidget {
  const SelectedView({Key key,this.item});
   
  final HomeTabBarItemView item;
  @override
  _SelectedViewState createState() => _SelectedViewState(item: item);
}

class _SelectedViewState extends State<SelectedView> 
  with AutomaticKeepAliveClientMixin<SelectedView>{
  _SelectedViewState({Key key,this.item});
  final List<LiveCardItem> listData=[];
  final HomeTabBarItemView item;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i=1;i<8;i++){
      listData.add(new LiveCardItem(view: "$i.$i 万",danmu: "$i$i",time: "12:01",));
    }
  }
  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle=Theme.of(context).textTheme.display1;
    return GridView.builder(
      gridDelegate:SliverGridDelegateWithMaxCrossAxisExtent(
        mainAxisSpacing: 5.0,
        crossAxisSpacing: 5.0,
        //childAspectRatio: 0.9,
        maxCrossAxisExtent: 300,
      ),
      itemCount: listData.length,
      itemBuilder: (BuildContext  contex,int index){
        return LiveCardItemView(liveCardItem: listData[index]);
      },
    );
  }
  
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

class LiveCardItem{
  LiveCardItem({this.danmu,this.imgurl,this.msg,this.name,this.time,this.view});
  String name;
  String time;
  String view;
  String danmu;
  String msg;
  String imgurl;
}

class LiveCardItemView extends StatelessWidget {
  LiveCardItem liveCardItem;
  LiveCardItemView({this.liveCardItem});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:10,),
      child: Card(
        color: Colors.white,
        child: new Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: 60.0,
              height: 120.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("images/fengmian1.jpg")
                ),
              ),
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                child: Row(
                  children: <Widget>[
                    Text(liveCardItem.view,style: TextStyle(color: Colors.white),),
                    Text("  "),
                    Text(liveCardItem.danmu,style: TextStyle(color: Colors.white),),
                    Text("  "),
                    Text(liveCardItem.time,style: TextStyle(color: Colors.white),),
                  ],
                ),
              )
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Column(

                children: <Widget>[
                  Text("【经典老番】监狱风云1",style: TextStyle(color: Colors.black,fontSize: 15),),

                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
