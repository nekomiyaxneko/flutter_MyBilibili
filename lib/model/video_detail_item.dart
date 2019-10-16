class VideoDetailItem {
	int code;
	String message;
	int ttl;
	Data data;
	VideoDetailItem.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		message = json['message'];
		ttl = json['ttl'];
		data = json['data'] != null ? new Data.fromJson(json['data']) : null;
	}

	
}

class Data {
	int aid;
	int videos;
	int tid;
	String tname;
	int copyright;
	String pic;
	String title;
	int pubdate;
	int ctime;
	String desc;
	int state;
	int attribute;
	int duration;
	Rights rights;
	Owner owner;
	Stat stat;
	int cid;
	Dimension dimension;
	List<Pages> pages;
	OwnerExt ownerExt;
	ReqUser reqUser;
	List<Tag> tag;
	int dmSeg;
	String shortLink;
	int playParam;
	Data.fromJson(Map<String, dynamic> json) {
		aid = json['aid'];
		videos = json['videos'];
		tid = json['tid'];
		tname = json['tname'];
		copyright = json['copyright'];
		pic = json['pic'];
		title = json['title'];
		pubdate = json['pubdate'];
		ctime = json['ctime'];
		desc = json['desc'];
		state = json['state'];
		attribute = json['attribute'];
		duration = json['duration'];
		rights = json['rights'] != null ? new Rights.fromJson(json['rights']) : null;
		owner = json['owner'] != null ? new Owner.fromJson(json['owner']) : null;
		stat = json['stat'] != null ? new Stat.fromJson(json['stat']) : null;
		cid = json['cid'];
		dimension = json['dimension'] != null ? new Dimension.fromJson(json['dimension']) : null;
		if (json['pages'] != null) {
			pages = new List<Pages>();
			json['pages'].forEach((v) { pages.add(new Pages.fromJson(v)); });
		}
		ownerExt = json['owner_ext'] != null ? new OwnerExt.fromJson(json['owner_ext']) : null;
		reqUser = json['req_user'] != null ? new ReqUser.fromJson(json['req_user']) : null;
		if (json['tag'] != null) {
			tag = new List<Tag>();
			json['tag'].forEach((v) { tag.add(new Tag.fromJson(v)); });
		}
		dmSeg = json['dm_seg'];
		shortLink = json['short_link'];
		playParam = json['play_param'];
	}

}

class Rights {
	int bp;
	int elec;
	int download;
	int movie;
	int pay;
	int hd5;
	int noReprint;
	int autoplay;
	int ugcPay;
	int isCooperation;
	int ugcPayPreview;

	Rights({this.bp, this.elec, this.download, this.movie, this.pay, this.hd5, this.noReprint, this.autoplay, this.ugcPay, this.isCooperation, this.ugcPayPreview});

	Rights.fromJson(Map<String, dynamic> json) {
		bp = json['bp'];
		elec = json['elec'];
		download = json['download'];
		movie = json['movie'];
		pay = json['pay'];
		hd5 = json['hd5'];
		noReprint = json['no_reprint'];
		autoplay = json['autoplay'];
		ugcPay = json['ugc_pay'];
		isCooperation = json['is_cooperation'];
		ugcPayPreview = json['ugc_pay_preview'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['bp'] = this.bp;
		data['elec'] = this.elec;
		data['download'] = this.download;
		data['movie'] = this.movie;
		data['pay'] = this.pay;
		data['hd5'] = this.hd5;
		data['no_reprint'] = this.noReprint;
		data['autoplay'] = this.autoplay;
		data['ugc_pay'] = this.ugcPay;
		data['is_cooperation'] = this.isCooperation;
		data['ugc_pay_preview'] = this.ugcPayPreview;
		return data;
	}
}

class Owner {
	int mid;
	String name;
	String face;

	Owner({this.mid, this.name, this.face});

	Owner.fromJson(Map<String, dynamic> json) {
		mid = json['mid'];
		name = json['name'];
		face = json['face'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mid'] = this.mid;
		data['name'] = this.name;
		data['face'] = this.face;
		return data;
	}
}

class Stat {
	int aid;
	int view;
	int danmaku;
	int reply;
	int favorite;
	int coin;
	int share;
	int nowRank;
	int hisRank;
	int like;
	int dislike;

	Stat({this.aid, this.view, this.danmaku, this.reply, this.favorite, this.coin, this.share, this.nowRank, this.hisRank, this.like, this.dislike});

	Stat.fromJson(Map<String, dynamic> json) {
		aid = json['aid'];
		view = json['view'];
		danmaku = json['danmaku'];
		reply = json['reply'];
		favorite = json['favorite'];
		coin = json['coin'];
		share = json['share'];
		nowRank = json['now_rank'];
		hisRank = json['his_rank'];
		like = json['like'];
		dislike = json['dislike'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['aid'] = this.aid;
		data['view'] = this.view;
		data['danmaku'] = this.danmaku;
		data['reply'] = this.reply;
		data['favorite'] = this.favorite;
		data['coin'] = this.coin;
		data['share'] = this.share;
		data['now_rank'] = this.nowRank;
		data['his_rank'] = this.hisRank;
		data['like'] = this.like;
		data['dislike'] = this.dislike;
		return data;
	}
}

class Dimension {
	int width;
	int height;
	int rotate;

	Dimension({this.width, this.height, this.rotate});

	Dimension.fromJson(Map<String, dynamic> json) {
		width = json['width'];
		height = json['height'];
		rotate = json['rotate'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['width'] = this.width;
		data['height'] = this.height;
		data['rotate'] = this.rotate;
		return data;
	}
}

class Pages {
	int cid;
	int page;
	String from;
	String part;
	int duration;
	String vid;
	String weblink;
	Dimension dimension;
	List<Metas> metas;
	String dmlink;
	Dm dm;

	Pages({this.cid, this.page, this.from, this.part, this.duration, this.vid, this.weblink, this.dimension, this.metas, this.dmlink, this.dm});

	Pages.fromJson(Map<String, dynamic> json) {
		cid = json['cid'];
		page = json['page'];
		from = json['from'];
		part = json['part'];
		duration = json['duration'];
		vid = json['vid'];
		weblink = json['weblink'];
		dimension = json['dimension'] != null ? new Dimension.fromJson(json['dimension']) : null;
		if (json['metas'] != null) {
			metas = new List<Metas>();
			json['metas'].forEach((v) { metas.add(new Metas.fromJson(v)); });
		}
		dmlink = json['dmlink'];
		dm = json['dm'] != null ? new Dm.fromJson(json['dm']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['cid'] = this.cid;
		data['page'] = this.page;
		data['from'] = this.from;
		data['part'] = this.part;
		data['duration'] = this.duration;
		data['vid'] = this.vid;
		data['weblink'] = this.weblink;
		if (this.dimension != null) {
      data['dimension'] = this.dimension.toJson();
    }
		if (this.metas != null) {
      data['metas'] = this.metas.map((v) => v.toJson()).toList();
    }
		data['dmlink'] = this.dmlink;
		if (this.dm != null) {
      data['dm'] = this.dm.toJson();
    }
		return data;
	}
}

class Metas {
	int quality;
	String format;
	int size;

	Metas({this.quality, this.format, this.size});

	Metas.fromJson(Map<String, dynamic> json) {
		quality = json['quality'];
		format = json['format'];
		size = json['size'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['quality'] = this.quality;
		data['format'] = this.format;
		data['size'] = this.size;
		return data;
	}
}

class Dm {
	bool closed;
	bool realName;
	int count;
	Mask mask;

	Dm({this.closed, this.realName, this.count, this.mask, });

	Dm.fromJson(Map<String, dynamic> json) {
		closed = json['closed'];
		realName = json['real_name'];
		count = json['count'];
		mask = json['mask'] != null ? new Mask.fromJson(json['mask']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['closed'] = this.closed;
		data['real_name'] = this.realName;
		data['count'] = this.count;
		if (this.mask != null) {
      data['mask'] = this.mask.toJson();
    }
		return data;
	}
}

class Mask {
	Mask.fromJson(Map<String, dynamic> json) {
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		return data;
	}
}

class OwnerExt {
	OfficialVerify officialVerify;
	Vip vip;
	int fans;

	OwnerExt({this.officialVerify, this.vip,  this.fans});

	OwnerExt.fromJson(Map<String, dynamic> json) {
		officialVerify = json['official_verify'] != null ? new OfficialVerify.fromJson(json['official_verify']) : null;
		vip = json['vip'] != null ? new Vip.fromJson(json['vip']) : null;
		fans = json['fans'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.officialVerify != null) {
      data['official_verify'] = this.officialVerify.toJson();
    }
		if (this.vip != null) {
      data['vip'] = this.vip.toJson();
    }
		data['fans'] = this.fans;
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
	Label label;

	Vip({this.vipType, this.vipDueDate, this.dueRemark, this.accessStatus, this.vipStatus, this.vipStatusWarn, this.themeType, this.label});

	Vip.fromJson(Map<String, dynamic> json) {
		vipType = json['vipType'];
		vipDueDate = json['vipDueDate'];
		dueRemark = json['dueRemark'];
		accessStatus = json['accessStatus'];
		vipStatus = json['vipStatus'];
		vipStatusWarn = json['vipStatusWarn'];
		themeType = json['themeType'];
		label = json['label'] != null ? new Label.fromJson(json['label']) : null;
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
		if (this.label != null) {
      data['label'] = this.label.toJson();
    }
		return data;
	}
}

class Label {
	String path;

	Label({this.path});

	Label.fromJson(Map<String, dynamic> json) {
		path = json['path'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['path'] = this.path;
		return data;
	}
}

class ReqUser {
	int attention;
	int favorite;
	int like;
	int dislike;
	int coin;

	ReqUser({this.attention, this.favorite, this.like, this.dislike, this.coin});

	ReqUser.fromJson(Map<String, dynamic> json) {
		attention = json['attention'];
		favorite = json['favorite'];
		like = json['like'];
		dislike = json['dislike'];
		coin = json['coin'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['attention'] = this.attention;
		data['favorite'] = this.favorite;
		data['like'] = this.like;
		data['dislike'] = this.dislike;
		data['coin'] = this.coin;
		return data;
	}
}

class Tag {
	int tagId;
	String tagName;
	String cover;
	int likes;
	int hates;
	int liked;
	int hated;
	int attribute;
	int isActivity;
	String uri;
	String tagType;

	Tag({this.tagId, this.tagName, this.cover, this.likes, this.hates, this.liked, this.hated, this.attribute, this.isActivity, this.uri, this.tagType});

	Tag.fromJson(Map<String, dynamic> json) {
		tagId = json['tag_id'];
		tagName = json['tag_name'];
		cover = json['cover'];
		likes = json['likes'];
		hates = json['hates'];
		liked = json['liked'];
		hated = json['hated'];
		attribute = json['attribute'];
		isActivity = json['is_activity'];
		uri = json['uri'];
		tagType = json['tag_type'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['tag_id'] = this.tagId;
		data['tag_name'] = this.tagName;
		data['cover'] = this.cover;
		data['likes'] = this.likes;
		data['hates'] = this.hates;
		data['liked'] = this.liked;
		data['hated'] = this.hated;
		data['attribute'] = this.attribute;
		data['is_activity'] = this.isActivity;
		data['uri'] = this.uri;
		data['tag_type'] = this.tagType;
		return data;
	}
}
