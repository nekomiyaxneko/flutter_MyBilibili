class VideoItemFromJson {
  int tid;
  String typename;
  String arctype;
  int play;
  int review;
  int videoReview;
  int favorites;
  String title;
  int allowBp;
  int allowFeed;
  int allowDownload;
  String description;
  Null tag;
  String pic;
  String author;
  int mid;
  String face;
  int pages;
  String instantServer;
  int created;
  String createdAt;
  String credit;
  int coins;
  Null spid;
  String src;
  int cid;
  String partname;
  String part;
  String from;
  String type;
  String vid;
  String offsite;
  List<VideoItemList> list;

  VideoItemFromJson(
      {this.tid,
      this.typename,
      this.arctype,
      this.play,
      this.review,
      this.videoReview,
      this.favorites,
      this.title,
      this.allowBp,
      this.allowFeed,
      this.allowDownload,
      this.description,
      this.tag,
      this.pic,
      this.author,
      this.mid,
      this.face,
      this.pages,
      this.instantServer,
      this.created,
      this.createdAt,
      this.credit,
      this.coins,
      this.spid,
      this.src,
      this.cid,
      this.partname,
      this.part,
      this.from,
      this.type,
      this.vid,
      this.offsite,
      this.list});

  VideoItemFromJson.fromJson(Map<String, dynamic> json) {
    tid = json['tid'];
    typename = json['typename'];
    arctype = json['arctype'];
    play = json['play'];
    review = json['review'];
    videoReview = json['video_review'];
    favorites = json['favorites'];
    title = json['title'];
    allowBp = json['allow_bp'];
    allowFeed = json['allow_feed'];
    allowDownload = json['allow_download'];
    description = json['description'];
    tag = json['tag'];
    pic = json['pic'];
    author = json['author'];
    mid = json['mid'];
    face = json['face'];
    pages = json['pages'];
    instantServer = json['instant_server'];
    created = json['created'];
    createdAt = json['created_at'];
    credit = json['credit'];
    coins = json['coins'];
    spid = json['spid'];
    src = json['src'];
    cid = json['cid'];
    partname = json['partname'];
    part = json['part'];
    from = json['from'];
    type = json['type'];
    vid = json['vid'];
    offsite = json['offsite'];
    if (json['list'] != null) {
      list = new List<VideoItemList>();
      json['list'].forEach((v) {
        list.add(new VideoItemList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tid'] = this.tid;
    data['typename'] = this.typename;
    data['arctype'] = this.arctype;
    data['play'] = this.play;
    data['review'] = this.review;
    data['video_review'] = this.videoReview;
    data['favorites'] = this.favorites;
    data['title'] = this.title;
    data['allow_bp'] = this.allowBp;
    data['allow_feed'] = this.allowFeed;
    data['allow_download'] = this.allowDownload;
    data['description'] = this.description;
    data['tag'] = this.tag;
    data['pic'] = this.pic;
    data['author'] = this.author;
    data['mid'] = this.mid;
    data['face'] = this.face;
    data['pages'] = this.pages;
    data['instant_server'] = this.instantServer;
    data['created'] = this.created;
    data['created_at'] = this.createdAt;
    data['credit'] = this.credit;
    data['coins'] = this.coins;
    data['spid'] = this.spid;
    data['src'] = this.src;
    data['cid'] = this.cid;
    data['partname'] = this.partname;
    data['part'] = this.part;
    data['from'] = this.from;
    data['type'] = this.type;
    data['vid'] = this.vid;
    data['offsite'] = this.offsite;
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class VideoItemList {
  int page;
  String type;
  String part;
  int cid;
  String weblink;
  String vid;
  bool hasAlias;

  VideoItemList(
      {this.page,
      this.type,
      this.part,
      this.cid,
      this.weblink,
      this.vid,
      this.hasAlias});

  VideoItemList.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    type = json['type'];
    part = json['part'];
    cid = json['cid'];
    weblink = json['weblink'];
    vid = json['vid'];
    hasAlias = json['has_alias'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['type'] = this.type;
    data['part'] = this.part;
    data['cid'] = this.cid;
    data['weblink'] = this.weblink;
    data['vid'] = this.vid;
    data['has_alias'] = this.hasAlias;
    return data;
  }
}
