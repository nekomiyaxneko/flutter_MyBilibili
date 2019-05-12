class RecommendListModel {
	int code;
	Config config;
	List<Data> data;
	String message;

	RecommendListModel({this.code, this.config, this.data, this.message});

	RecommendListModel.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		config =
		json['config'] != null ? new Config.fromJson(json['config']) : null;
		if (json['data'] != null) {
			data = new List<Data>();
			json['data'].forEach((v) {
				data.add(new Data.fromJson(v));
			});
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.config != null) {
			data['config'] = this.config.toJson();
		}
		if (this.data != null) {
			data['data'] = this.data.map((v) => v.toJson()).toList();
		}
		data['message'] = this.message;
		return data;
	}
}

class Config {
	int feedCleanAbtest;

	Config({this.feedCleanAbtest});

	Config.fromJson(Map<String, dynamic> json) {
		feedCleanAbtest = json['feed_clean_abtest'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['feed_clean_abtest'] = this.feedCleanAbtest;
		return data;
	}
}

class Data {
	String title;
	String cover;
	String uri;
	String param;
	String goto;
	String desc;
	int play;
	int danmaku;
	int reply;
	int favorite;
	int coin;
	int share;
	int like;
	int duration;
	int idx;
	int cid;
	int tid;
	String tname;
	List<DislikeReasons> dislikeReasons;
	int ctime;
	int autoplay;
	int mid;
	String name;
	String face;
	Official official;
	int autoplayCard;

	Data(
			{this.title,
				this.cover,
				this.uri,
				this.param,
				this.goto,
				this.desc,
				this.play,
				this.danmaku,
				this.reply,
				this.favorite,
				this.coin,
				this.share,
				this.like,
				this.duration,
				this.idx,
				this.cid,
				this.tid,
				this.tname,
				this.dislikeReasons,
				this.ctime,
				this.autoplay,
				this.mid,
				this.name,
				this.face,
				this.official,
				this.autoplayCard});

	Data.fromJson(Map<String, dynamic> json) {
		title = json['title'];
		cover = json['cover'];
		uri = json['uri'];
		param = json['param'];
		goto = json['goto'];
		desc = json['desc'];
		play = json['play'];
		danmaku = json['danmaku'];
		reply = json['reply'];
		favorite = json['favorite'];
		coin = json['coin'];
		share = json['share'];
		like = json['like'];
		duration = json['duration'];
		idx = json['idx'];
		cid = json['cid'];
		tid = json['tid'];
		tname = json['tname'];
		if (json['dislike_reasons'] != null) {
			dislikeReasons = new List<DislikeReasons>();
			json['dislike_reasons'].forEach((v) {
				dislikeReasons.add(new DislikeReasons.fromJson(v));
			});
		}
		ctime = json['ctime'];
		autoplay = json['autoplay'];
		mid = json['mid'];
		name = json['name'];
		face = json['face'];
		official = json['official'] != null
				? new Official.fromJson(json['official'])
				: null;
		autoplayCard = json['autoplay_card'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['title'] = this.title;
		data['cover'] = this.cover;
		data['uri'] = this.uri;
		data['param'] = this.param;
		data['goto'] = this.goto;
		data['desc'] = this.desc;
		data['play'] = this.play;
		data['danmaku'] = this.danmaku;
		data['reply'] = this.reply;
		data['favorite'] = this.favorite;
		data['coin'] = this.coin;
		data['share'] = this.share;
		data['like'] = this.like;
		data['duration'] = this.duration;
		data['idx'] = this.idx;
		data['cid'] = this.cid;
		data['tid'] = this.tid;
		data['tname'] = this.tname;
		if (this.dislikeReasons != null) {
			data['dislike_reasons'] =
					this.dislikeReasons.map((v) => v.toJson()).toList();
		}
		data['ctime'] = this.ctime;
		data['autoplay'] = this.autoplay;
		data['mid'] = this.mid;
		data['name'] = this.name;
		data['face'] = this.face;
		if (this.official != null) {
			data['official'] = this.official.toJson();
		}
		data['autoplay_card'] = this.autoplayCard;
		return data;
	}
}

class DislikeReasons {
	int reasonId;
	String reasonName;

	DislikeReasons({this.reasonId, this.reasonName});

	DislikeReasons.fromJson(Map<String, dynamic> json) {
		reasonId = json['reason_id'];
		reasonName = json['reason_name'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['reason_id'] = this.reasonId;
		data['reason_name'] = this.reasonName;
		return data;
	}
}

class Official {
	int role;
	String title;

	Official({this.role, this.title});

	Official.fromJson(Map<String, dynamic> json) {
		role = json['role'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['role'] = this.role;
		data['title'] = this.title;
		return data;
	}
}
