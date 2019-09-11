import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_MyBilibili/model/jsonmodel/GoodItem.dart';
import 'package:flutter_MyBilibili/util/GetUtilBilibili.dart';

class MallPage extends StatefulWidget {
  @override
  _MallPageState createState() => _MallPageState();
}

class _MallPageState extends State<MallPage> {
  List<String> bannerlist=[//banner列表
    "http://i0.hdslb.com/bfs/openplatform/201905/1242x4201557282234340.jpeg",
    "http://i0.hdslb.com/bfs/openplatform/201905/1242new1557302829737.jpeg",
    "http://i1.hdslb.com/bfs/openplatform/201905/12421557397375753.jpeg",
    "http://i1.hdslb.com/bfs/openplatform/201905/BML1557480532077.jpeg",
    "http://i2.hdslb.com/bfs/openplatform/201905/12421557129720654.jpeg",
  ];
  List<GoodItem> goodlist=List<GoodItem>();
  ScrollController _scrollController = new ScrollController();
  bool isrefresh=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMallData();
  }
  Future<void> getMallData()async{//初始化
    goodlist.addAll(await GetUtilBilibili.getMallList());
    setState(() {
      
    });
  }
  Future<void> _onReFreshMall()async{//下拉刷新的函数返回值必须是Future<void>，之前没注意到一直报错
    isrefresh=true;
    goodlist.clear();
    goodlist.addAll(await GetUtilBilibili.getMallList());
    setState(() {
     isrefresh=false;
    });
  }
  void _getMoreMallData()async{//加载更多
    goodlist.addAll(await GetUtilBilibili.getMallList());
    setState(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    return buildIndexListView();
  }
  Widget buildIndexListView(){
    return RefreshIndicator(
      onRefresh: _onReFreshMall,
      child: ListView(
        //controller: _scrollController,
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          buildTopSearch(),
          buildTabs(),
          buildBlocks(),
          buildBanners(),
          buildGridView(),
        ],
      ),
    );

  }
  buildTopSearch(){//顶部搜索栏
    return Container(
      height: 40,
      alignment: Alignment.center,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.grey[200]
      ),
      child: Container(
        width: 200,
        margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
        alignment: Alignment.center,
        child: TextField(
          decoration: InputDecoration(
            icon: Icon(Icons.search,color: Colors.pink[300],size: 20,),
            hintText: "手办模玩、展览演出",
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: 14)
          ),
        ),
      ),
    );
  }
  buildTabs(){//分区列表
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        TabPage("http://i0.hdslb.com/bfs/mall/mall/ff/a9/ffa981909ec568972dc476a4891c91db.png","手办"),
        TabPage("http://i0.hdslb.com/bfs/mall/mall/90/a2/90a2604b0b3ed5a4b0a8110d1c3b6b7c.png","模型"),
        TabPage("http://i0.hdslb.com/bfs/mall/mall/7f/b9/7fb9c1351a8eb1d3071d8bcbec6653b7.png","漫展演出"),
        TabPage("http://i0.hdslb.com/bfs/mall/mall/be/58/be58af018d88ea87382960e5d5f6d322.png","周边"),
        TabPage("http://i0.hdslb.com/bfs/mall/mall/21/1c/211c98c6efdf471c4d377a2f36c74b01.png","全部分类"),
      ],
    );
  }
  buildBlocks(){//block列表
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(10, 10, 5, 10),
            child: Image.network("http://i0.hdslb.com/bfs/mall/mall/49/c4/49c47bb4e5138edd96b04bcbc41a6488.png",fit: BoxFit.fitWidth,),
          ),
        ),
        Expanded(
          child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Image.network("http://i0.hdslb.com/bfs/mall/mall/14/29/1429e0e891a351c745b4fca6136b2fc9.png"),
        ),
        ),
        Expanded(
          child: Container(
          margin: EdgeInsets.fromLTRB(5, 10, 10, 10),
          child: Image.network("http://i0.hdslb.com/bfs/mall/mall/ad/2e/ad2e11096cc4a3537bfa2d5f88938a4e.png"),
        ),
        ),
        
      ],
    );
  }
  Widget buildBanners(){//滚动栏
    return Container(
      height: 120,
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Swiper(
        itemCount: 5,
        autoplay: true,
        pagination: new SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.black54,
            activeColor: Colors.pink[300],
        )
        ),
        itemBuilder: (contex,i){
          return Container(
            child: Image.network(bannerlist[i],fit: BoxFit.fitWidth,),
          );
        },
      ),
    );
  }
  Widget buildGridView(){
    return Container(
      color: Colors.grey[200],
      child: GridView.builder(
        padding: EdgeInsets.fromLTRB(7, 5, 7, 0),
        controller: ScrollController(),
        physics:  ScrollPhysics(),
        shrinkWrap:true,
        itemCount: goodlist.length,
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(//控制主轴/纵轴之间空隙，列数，宽高比
          mainAxisSpacing: 5.0,
          crossAxisSpacing: 7.0,
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context,i){
          print(i);
          if(i>=goodlist.length-1){
            //_getMoreMallData(); 
          }
          return MallCard(goodlist[i]);
        },
      ),
    );
    
  }
}

class TabPage extends StatelessWidget {//单个分区
  String cover;
  String name;
  TabPage(String cover,String name){
    this.name=name;
    this.cover=cover;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(cover)),
          ),
        ),
        Text(name),
      ],
    );
  }
}

class MallCard extends StatelessWidget {
  GoodItem item;
  MallCard(GoodItem item){
    this.item=item;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Image.network(item.cover+"@320w_200h.jpg",fit: BoxFit.contain),
          ),
          Container(
            height: 10,
          ),
          Text(item.title,style: TextStyle(),maxLines: 2,),
          Container(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(item.priceSymbol+item.price,style: TextStyle(color: Colors.pink[300],fontSize: 15),),
              ),
              Expanded(
                child: Text(item.like,style: TextStyle(color: Colors.black45,fontSize: 13),),
              ),
            ],
          ),
        ],
      ),
      
    );
  }
}