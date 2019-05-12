import 'package:flutter/material.dart';
import 'package:mytest/model/jsonmodel/ChannelItem.dart';
import 'package:mytest/pages/SecondPage.dart';
import 'package:mytest/util/GetUtilBilibili.dart';

class ChannelPage extends StatefulWidget {
  @override
  _ChannelPageState createState() => _ChannelPageState();
}

class _ChannelPageState extends State<ChannelPage> {
  List<ChannelItem> channellist=List<ChannelItem>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getChannelList();
  }
  getChannelList() async{
    channellist.addAll(await GetUtilBilibili.getChannelList());
    setState(() {
      
    });
  }
  Future<void> _onrefresh()async{
    channellist.clear();
    channellist.addAll(await GetUtilBilibili.getChannelList());
    setState(() {
      
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildChannelGridView();
  }
  Widget buildChannelGridView(){
    return RefreshIndicator(
      onRefresh: _onrefresh,
        child: GridView.builder(
        itemCount: channellist.length,
        physics: AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(5),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 4,
          childAspectRatio: 1,
        ),
        itemBuilder: (context,i){
          return ChannelCard(channellist[i]);
        },
      ),
    );
    
  }
}
class ChannelCard extends StatelessWidget {
  ChannelItem item;
  ChannelCard(ChannelItem i){
    this.item=i;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(//图标
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage(item.logo))
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(item.name,style: TextStyle(letterSpacing: 3,fontSize: 12),)//文字
          ],
        ),
      ),
      
    );
  }
}