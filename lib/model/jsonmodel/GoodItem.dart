class GoodItem{
  String cover="";
  String title="";
  String price="";
  String priceSymbol="";
  String like="";
  GoodItem.fromJson(Map<String,dynamic> jsondata){
    title=jsondata["title"];
    if(jsondata["imageUrls"][0]!=null){
      cover="http:"+jsondata["imageUrls"][0];
    }
    if(jsondata["price"][0]!=null){
      price=jsondata["price"][0].toString();
    }
    priceSymbol=jsondata["priceSymbol"];
    
    if(jsondata["type"]=="ticketproject"){
      like=jsondata["want"];
    }
    else if(jsondata["type"]=="mallitems"){
      if(jsondata["like"]>10000){
        like=(jsondata["like"]/10000).toStringAsFixed(1)+"万人想要";//保留1位小数
      }
      else{
        like=jsondata["like"].toString()+"人想要";
      }
    }
    
  }
}