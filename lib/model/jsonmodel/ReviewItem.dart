class ReviewItem{
  String uname;
  int floor;
  String message;
  String pic;
  int like;
  int level;
  int vipStatus;
  int ctime;
  ReviewItem(Map<String, dynamic> jsondata){
    this.floor=jsondata["floor"];
    this.ctime=jsondata["ctime"];
    this.like=jsondata["like"];
    this.message=jsondata["content"]["message"];
    this.pic=jsondata["member"]["avatar"];
    this.uname=jsondata["member"]["uname"];
    this.level=jsondata["member"]["level_info"]["current_level"];
    this.vipStatus=jsondata["member"]["vip"]["vipStatus"];
  }

}