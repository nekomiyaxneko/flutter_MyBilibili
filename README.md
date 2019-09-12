# flutter_MyBilibili

一个基于flutter的高仿bilibili

# 已经实现的功能
* 首页
	* 推荐-下拉刷新，加载更多
	* 直播-下拉刷新
* 搜索
	* 支持关键字和av号搜索
	* 热搜推荐
	* 历史纪录
* 播放界面，
	* 可以看到视频信息和评论（评论暂时只做了前面的热评和一些最新的评论）
	* 点击封面可以保存封面到相册
* 频道
	* 获取实时频道列表
* 动态
	* 显示未登录
* 会员购
	* 下拉刷新，加载更多（后来由于可能会闪退去掉了加载更多）
* 侧边栏
	* 显示头像，昵称，等（见截图）
* 登陆
	* 简单的登陆界面，输入密码时候2233会遮住眼睛

# 获取方式

### 点击链接下载安装包
[下载](release/app-release.apk)

### clone本项目自行build

# 界面

|              描述                        |       预览                  |
| :----------------------------: | :-----------------------: |
|     启动页       | ![splash](screenshot/splash.png) |
|       推荐/直播     | ![home](screenshot/home.png) ![live](screenshot/live.png) |
|       播放/评论页面     | ![play](screenshot/play.png) ![reply](screenshot/play_reply.png) |
|     保存封面并查看    |![save_cover](screenshot/save_cover.png)![save_cover_ok](screenshot/save_cover_ok.png)|
|      搜索推荐/搜索记录/结果      | ![search](screenshot/search.png) ![search_result](screenshot/search_result.png) |
|  登陆/输入密码| ![login](screenshot/login.png) ![login_input_password](screenshot/login_input_password.png) |
|      频道      | ![dynamic](screenshot/channel.png) |
|      动态      | ![mall](screenshot/dynamic.png) |
|      会员购      | ![play_detail](screenshot/mall.png) |


# TODO

- [x] 搜索
	- [x] 搜索记录
	- [x] 热门推荐
	- [ ] 搜索输入推荐

- [x] 附加功能
	- [x] 封面保存

