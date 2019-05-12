class ChannelItem{
  int tid;
  String name;
  String logo;
  ChannelItem({this.logo,this.name,this.tid});
  ChannelItem.fromJson(Map<String ,dynamic> jsondata){
    tid=jsondata["tid"];
    name=jsondata["name"];
    logo=jsondata["logo"];
  }
}