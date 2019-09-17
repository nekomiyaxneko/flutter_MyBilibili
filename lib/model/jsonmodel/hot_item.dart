class HotVideoItem {
  String title;
  String aid;
  String cover;
  String coverRightText_1;
  String rightDesc_1;
  String rightDesc_2;
  RcmdReasonStyle rcmdReasonStyle;
  HotVideoItem.fromJson(Map<String, dynamic> jd) {
    title = jd["title"];
    aid = jd["param"];
    cover = jd["cover"];
    coverRightText_1 = jd["cover_right_text_1"];
    rightDesc_1 = jd["right_desc_1"];
    rightDesc_2 = jd["right_desc_2"];
    if (jd["rcmd_reason_style"]!=null) {
      rcmdReasonStyle = RcmdReasonStyle.fromJson(jd["rcmd_reason_style"]);
    }
  }
}

class RcmdReasonStyle {
  String text;
  String textColor;
  String bgColor;
  String borderColor;
  RcmdReasonStyle.fromJson(Map<String, dynamic> jd) {
    text = jd["text"];
    textColor = jd["text_color"];
    bgColor = jd["bg_color"];
    borderColor = jd["border_color"];
  }
}

class HotTopItem{
  String icon;
  String title;
  HotTopItem.fromJson(Map<String,dynamic> jd){
    icon=jd["icon"];
    title=jd["title"];
  }
}

class HotUpItem {
  String title;
  String mid;
  String cover;
  String coverRightText_1;
  RcmdReasonStyle rcmdReasonStyle;
  List<UpVideoItem> upVideoList;
  HotUpItem.fromJson(Map<String, dynamic> jd) {
    title = jd["title"];
    mid = jd["param"];
    cover = jd["cover"];
    coverRightText_1 = jd["cover_right_text_1"];
    if (jd["top_rcmd_reason_style"]!=null) {
      rcmdReasonStyle = RcmdReasonStyle.fromJson(jd["top_rcmd_reason_style"]);
    }
    if(jd["item"]!=null){
      upVideoList=List<UpVideoItem>();
      for(Map<String,dynamic> it in jd["item"]){
        upVideoList.add(UpVideoItem.fromJson(it));
      }
    }
  }
}

class UpVideoItem {
  String title;
  String aid;
  String cover;
  String coverLeftText_1;
  String coverRighText;
  RcmdReasonStyle rcmdReasonStyle;
  UpVideoItem.fromJson(Map<String, dynamic> jd) {
    title = jd["title"];
    aid = jd["param"];
    cover = jd["cover"];
    coverLeftText_1 = jd["cover_left_text_1"];
    coverRighText = jd["cover_right_text"];
  }
}