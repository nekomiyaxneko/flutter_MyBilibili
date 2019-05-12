class ReviewList {
  int code;
  String message;
  int ttl;
  ReviewData data;

  ReviewList({this.code, this.message, this.ttl, this.data});

  ReviewList.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    ttl = json['ttl'];
    data = json['data'] != null ? new ReviewData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    data['ttl'] = this.ttl;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ReviewData {
  ReviewPage page;
  Config config;
  List<Replies> replies;
  List<Hots> hots;
  Upper upper;
  Null top;
  Null notice;
  int vote;
  int blacklist;
  int assist;
  int mode;
  List<int> supportMode;
  Folder folder;

  ReviewData(
      {this.page,
        this.config,
        this.replies,
        this.hots,
        this.upper,
        this.top,
        this.notice,
        this.vote,
        this.blacklist,
        this.assist,
        this.mode,
        this.supportMode,
        this.folder});

  ReviewData.fromJson(Map<String, dynamic> json) {
    page = json['page'] != null ? new ReviewPage.fromJson(json['page']) : null;
    config =
    json['config'] != null ? new Config.fromJson(json['config']) : null;
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
    if (json['hots'] != null) {
      hots = new List<Hots>();
      json['hots'].forEach((v) {
        hots.add(new Hots.fromJson(v));
      });
    }
    upper = json['upper'] != null ? new Upper.fromJson(json['upper']) : null;
    top = json['top'];
    notice = json['notice'];
    vote = json['vote'];
    blacklist = json['blacklist'];
    assist = json['assist'];
    mode = json['mode'];
    supportMode = json['support_mode'].cast<int>();
    folder =
    json['folder'] != null ? new Folder.fromJson(json['folder']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.page != null) {
      data['page'] = this.page.toJson();
    }
    if (this.config != null) {
      data['config'] = this.config.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    if (this.hots != null) {
      data['hots'] = this.hots.map((v) => v.toJson()).toList();
    }
    if (this.upper != null) {
      data['upper'] = this.upper.toJson();
    }
    data['top'] = this.top;
    data['notice'] = this.notice;
    data['vote'] = this.vote;
    data['blacklist'] = this.blacklist;
    data['assist'] = this.assist;
    data['mode'] = this.mode;
    data['support_mode'] = this.supportMode;
    if (this.folder != null) {
      data['folder'] = this.folder.toJson();
    }
    return data;
  }
}

class ReviewPage {
  int num;
  int size;
  int count;
  int acount;

  ReviewPage({this.num, this.size, this.count, this.acount});

  ReviewPage.fromJson(Map<String, dynamic> json) {
    num = json['num'];
    size = json['size'];
    count = json['count'];
    acount = json['acount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num'] = this.num;
    data['size'] = this.size;
    data['count'] = this.count;
    data['acount'] = this.acount;
    return data;
  }
}

class Config {
  int showadmin;
  int showentry;
  int showfloor;
  int showtopic;
  bool showUpFlag;
  bool readOnly;
  bool showDelLog;

  Config(
      {this.showadmin,
        this.showentry,
        this.showfloor,
        this.showtopic,
        this.showUpFlag,
        this.readOnly,
        this.showDelLog});

  Config.fromJson(Map<String, dynamic> json) {
    showadmin = json['showadmin'];
    showentry = json['showentry'];
    showfloor = json['showfloor'];
    showtopic = json['showtopic'];
    showUpFlag = json['show_up_flag'];
    readOnly = json['read_only'];
    showDelLog = json['show_del_log'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['showadmin'] = this.showadmin;
    data['showentry'] = this.showentry;
    data['showfloor'] = this.showfloor;
    data['showtopic'] = this.showtopic;
    data['show_up_flag'] = this.showUpFlag;
    data['read_only'] = this.readOnly;
    data['show_del_log'] = this.showDelLog;
    return data;
  }
}

class Replies {
  int rpid;
  int oid;
  int type;
  int mid;
  int root;
  int parent;
  int dialog;
  int count;
  int rcount;
  int floor;
  int state;
  int fansgrade;
  int attr;
  int ctime;
  String rpidStr;
  String rootStr;
  String parentStr;
  int like;
  int action;
  Member member;
  Content content;
  Null replies;
  int assist;
  Folder folder;
  UpAction upAction;

  Replies(
      {this.rpid,
        this.oid,
        this.type,
        this.mid,
        this.root,
        this.parent,
        this.dialog,
        this.count,
        this.rcount,
        this.floor,
        this.state,
        this.fansgrade,
        this.attr,
        this.ctime,
        this.rpidStr,
        this.rootStr,
        this.parentStr,
        this.like,
        this.action,
        this.member,
        this.content,
        this.replies,
        this.assist,
        this.folder,
        this.upAction});

  Replies.fromJson(Map<String, dynamic> json) {
    rpid = json['rpid'];
    oid = json['oid'];
    type = json['type'];
    mid = json['mid'];
    root = json['root'];
    parent = json['parent'];
    dialog = json['dialog'];
    count = json['count'];
    rcount = json['rcount'];
    floor = json['floor'];
    state = json['state'];
    fansgrade = json['fansgrade'];
    attr = json['attr'];
    ctime = json['ctime'];
    rpidStr = json['rpid_str'];
    rootStr = json['root_str'];
    parentStr = json['parent_str'];
    like = json['like'];
    action = json['action'];
    member =
    json['member'] != null ? new Member.fromJson(json['member']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    replies = json['replies'];
    assist = json['assist'];
    folder =
    json['folder'] != null ? new Folder.fromJson(json['folder']) : null;
    upAction = json['up_action'] != null
        ? new UpAction.fromJson(json['up_action'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rpid'] = this.rpid;
    data['oid'] = this.oid;
    data['type'] = this.type;
    data['mid'] = this.mid;
    data['root'] = this.root;
    data['parent'] = this.parent;
    data['dialog'] = this.dialog;
    data['count'] = this.count;
    data['rcount'] = this.rcount;
    data['floor'] = this.floor;
    data['state'] = this.state;
    data['fansgrade'] = this.fansgrade;
    data['attr'] = this.attr;
    data['ctime'] = this.ctime;
    data['rpid_str'] = this.rpidStr;
    data['root_str'] = this.rootStr;
    data['parent_str'] = this.parentStr;
    data['like'] = this.like;
    data['action'] = this.action;
    if (this.member != null) {
      data['member'] = this.member.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    data['replies'] = this.replies;
    data['assist'] = this.assist;
    if (this.folder != null) {
      data['folder'] = this.folder.toJson();
    }
    if (this.upAction != null) {
      data['up_action'] = this.upAction.toJson();
    }
    return data;
  }
}

class Member {
  String mid;
  String uname;
  String sex;
  String sign;
  String avatar;
  String rank;
  String displayRank;
  LevelInfo levelInfo;
  Pendant pendant;
  Nameplate nameplate;
  OfficialVerify officialVerify;
  Vip vip;
  Null fansDetail;
  int following;

  Member(
      {this.mid,
        this.uname,
        this.sex,
        this.sign,
        this.avatar,
        this.rank,
        this.displayRank,
        this.levelInfo,
        this.pendant,
        this.nameplate,
        this.officialVerify,
        this.vip,
        this.fansDetail,
        this.following});

  Member.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    uname = json['uname'];
    sex = json['sex'];
    sign = json['sign'];
    avatar = json['avatar'];
    rank = json['rank'];
    displayRank = json['DisplayRank'];
    levelInfo = json['level_info'] != null
        ? new LevelInfo.fromJson(json['level_info'])
        : null;
    pendant =
    json['pendant'] != null ? new Pendant.fromJson(json['pendant']) : null;
    nameplate = json['nameplate'] != null
        ? new Nameplate.fromJson(json['nameplate'])
        : null;
    officialVerify = json['official_verify'] != null
        ? new OfficialVerify.fromJson(json['official_verify'])
        : null;
    vip = json['vip'] != null ? new Vip.fromJson(json['vip']) : null;
    fansDetail = json['fans_detail'];
    following = json['following'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['uname'] = this.uname;
    data['sex'] = this.sex;
    data['sign'] = this.sign;
    data['avatar'] = this.avatar;
    data['rank'] = this.rank;
    data['DisplayRank'] = this.displayRank;
    if (this.levelInfo != null) {
      data['level_info'] = this.levelInfo.toJson();
    }
    if (this.pendant != null) {
      data['pendant'] = this.pendant.toJson();
    }
    if (this.nameplate != null) {
      data['nameplate'] = this.nameplate.toJson();
    }
    if (this.officialVerify != null) {
      data['official_verify'] = this.officialVerify.toJson();
    }
    if (this.vip != null) {
      data['vip'] = this.vip.toJson();
    }
    data['fans_detail'] = this.fansDetail;
    data['following'] = this.following;
    return data;
  }
}

class LevelInfo {
  int currentLevel;
  int currentMin;
  int currentExp;
  int nextExp;

  LevelInfo(
      {this.currentLevel, this.currentMin, this.currentExp, this.nextExp});

  LevelInfo.fromJson(Map<String, dynamic> json) {
    currentLevel = json['current_level'];
    currentMin = json['current_min'];
    currentExp = json['current_exp'];
    nextExp = json['next_exp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_level'] = this.currentLevel;
    data['current_min'] = this.currentMin;
    data['current_exp'] = this.currentExp;
    data['next_exp'] = this.nextExp;
    return data;
  }
}

class Pendant {
  int pid;
  String name;
  String image;
  int expire;

  Pendant({this.pid, this.name, this.image, this.expire});

  Pendant.fromJson(Map<String, dynamic> json) {
    pid = json['pid'];
    name = json['name'];
    image = json['image'];
    expire = json['expire'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pid'] = this.pid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['expire'] = this.expire;
    return data;
  }
}

class Nameplate {
  int nid;
  String name;
  String image;
  String imageSmall;
  String level;
  String condition;

  Nameplate(
      {this.nid,
        this.name,
        this.image,
        this.imageSmall,
        this.level,
        this.condition});

  Nameplate.fromJson(Map<String, dynamic> json) {
    nid = json['nid'];
    name = json['name'];
    image = json['image'];
    imageSmall = json['image_small'];
    level = json['level'];
    condition = json['condition'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nid'] = this.nid;
    data['name'] = this.name;
    data['image'] = this.image;
    data['image_small'] = this.imageSmall;
    data['level'] = this.level;
    data['condition'] = this.condition;
    return data;
  }
}

class OfficialVerify {
  int type;
  String desc;

  OfficialVerify({this.type, this.desc});

  OfficialVerify.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    desc = json['desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['desc'] = this.desc;
    return data;
  }
}

class Vip {
  int vipType;
  int vipDueDate;
  String dueRemark;
  int accessStatus;
  int vipStatus;
  String vipStatusWarn;
  int themeType;

  Vip(
      {this.vipType,
        this.vipDueDate,
        this.dueRemark,
        this.accessStatus,
        this.vipStatus,
        this.vipStatusWarn,
        this.themeType});

  Vip.fromJson(Map<String, dynamic> json) {
    vipType = json['vipType'];
    vipDueDate = json['vipDueDate'];
    dueRemark = json['dueRemark'];
    accessStatus = json['accessStatus'];
    vipStatus = json['vipStatus'];
    vipStatusWarn = json['vipStatusWarn'];
    themeType = json['themeType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vipType'] = this.vipType;
    data['vipDueDate'] = this.vipDueDate;
    data['dueRemark'] = this.dueRemark;
    data['accessStatus'] = this.accessStatus;
    data['vipStatus'] = this.vipStatus;
    data['vipStatusWarn'] = this.vipStatusWarn;
    data['themeType'] = this.themeType;
    return data;
  }
}

class Content {
  String message;
  int plat;
  String device;
  List members;

  Content({this.message, this.plat, this.device, this.members});

  Content.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    plat = json['plat'];
    device = json['device'];
    if (json['members'] != null) {
      members = new List<Null>();
      json['members'].forEach((v) {
        members.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['plat'] = this.plat;
    data['device'] = this.device;
    if (this.members != null) {
      data['members'] = this.members.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Folder {
  bool hasFolded;
  bool isFolded;
  String rule;

  Folder({this.hasFolded, this.isFolded, this.rule});

  Folder.fromJson(Map<String, dynamic> json) {
    hasFolded = json['has_folded'];
    isFolded = json['is_folded'];
    rule = json['rule'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['has_folded'] = this.hasFolded;
    data['is_folded'] = this.isFolded;
    data['rule'] = this.rule;
    return data;
  }
}

class UpAction {
  bool like;
  bool reply;

  UpAction({this.like, this.reply});

  UpAction.fromJson(Map<String, dynamic> json) {
    like = json['like'];
    reply = json['reply'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['like'] = this.like;
    data['reply'] = this.reply;
    return data;
  }
}

class Hots {
  int rpid;
  int oid;
  int type;
  int mid;
  int root;
  int parent;
  int dialog;
  int count;
  int rcount;
  int floor;
  int state;
  int fansgrade;
  int attr;
  int ctime;
  String rpidStr;
  String rootStr;
  String parentStr;
  int like;
  int action;
  Member member;
  Content content;
  List<Replies> replies;
  int assist;
  Folder folder;
  UpAction upAction;

  Hots(
      {this.rpid,
        this.oid,
        this.type,
        this.mid,
        this.root,
        this.parent,
        this.dialog,
        this.count,
        this.rcount,
        this.floor,
        this.state,
        this.fansgrade,
        this.attr,
        this.ctime,
        this.rpidStr,
        this.rootStr,
        this.parentStr,
        this.like,
        this.action,
        this.member,
        this.content,
        this.replies,
        this.assist,
        this.folder,
        this.upAction});

  Hots.fromJson(Map<String, dynamic> json) {
    rpid = json['rpid'];
    oid = json['oid'];
    type = json['type'];
    mid = json['mid'];
    root = json['root'];
    parent = json['parent'];
    dialog = json['dialog'];
    count = json['count'];
    rcount = json['rcount'];
    floor = json['floor'];
    state = json['state'];
    fansgrade = json['fansgrade'];
    attr = json['attr'];
    ctime = json['ctime'];
    rpidStr = json['rpid_str'];
    rootStr = json['root_str'];
    parentStr = json['parent_str'];
    like = json['like'];
    action = json['action'];
    member =
    json['member'] != null ? new Member.fromJson(json['member']) : null;
    content =
    json['content'] != null ? new Content.fromJson(json['content']) : null;
    if (json['replies'] != null) {
      replies = new List<Replies>();
      json['replies'].forEach((v) {
        replies.add(new Replies.fromJson(v));
      });
    }
    assist = json['assist'];
    folder =
    json['folder'] != null ? new Folder.fromJson(json['folder']) : null;
    upAction = json['up_action'] != null
        ? new UpAction.fromJson(json['up_action'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rpid'] = this.rpid;
    data['oid'] = this.oid;
    data['type'] = this.type;
    data['mid'] = this.mid;
    data['root'] = this.root;
    data['parent'] = this.parent;
    data['dialog'] = this.dialog;
    data['count'] = this.count;
    data['rcount'] = this.rcount;
    data['floor'] = this.floor;
    data['state'] = this.state;
    data['fansgrade'] = this.fansgrade;
    data['attr'] = this.attr;
    data['ctime'] = this.ctime;
    data['rpid_str'] = this.rpidStr;
    data['root_str'] = this.rootStr;
    data['parent_str'] = this.parentStr;
    data['like'] = this.like;
    data['action'] = this.action;
    if (this.member != null) {
      data['member'] = this.member.toJson();
    }
    if (this.content != null) {
      data['content'] = this.content.toJson();
    }
    if (this.replies != null) {
      data['replies'] = this.replies.map((v) => v.toJson()).toList();
    }
    data['assist'] = this.assist;
    if (this.folder != null) {
      data['folder'] = this.folder.toJson();
    }
    if (this.upAction != null) {
      data['up_action'] = this.upAction.toJson();
    }
    return data;
  }
}

class Upper {
  int mid;
  Null top;
  Null vote;

  Upper({this.mid, this.top, this.vote});

  Upper.fromJson(Map<String, dynamic> json) {
    mid = json['mid'];
    top = json['top'];
    vote = json['vote'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mid'] = this.mid;
    data['top'] = this.top;
    data['vote'] = this.vote;
    return data;
  }
}
