# flutter_bilibili
------------------
# 简介
---------------------------
flutter练习项目 
参考哔哩哔哩安卓客户端5.47版本的界面

# 更新日志
---------------------------
* 2019/10/16
	详情可以查看粉丝数
* 2019/10/17
	修复视频无法播放
	改善视频清晰度，目前最大支持720p。（以前是360p？不，感觉还要更低）
* 2019/10/20
	新增弹幕播放功能


# 存在问题
--------------------------
* 2019/10/16
	~~视频播放api无法使用~~
* 2019/10/17 
	播放视频时如果调进度条会从头开始

# 功能
----------------------------
* 首页
	* 推荐-下拉刷新，加载更多
	* 热门top100下拉刷新，加载更多
	* 追番页面
	* 影视页面
	* 70周年页面
	* 直播推荐-下拉刷新-**可以看直播啦**
* 搜索
	* 支持关键字和av号搜索
	* 热搜推荐和搜索记录
	* 支持按照默认/播放量/弹幕数/新发布排序
* 播放
	* **可以播放视频了！**
	* **可以看弹幕！**
	* 可以看到视频信息和评论（评论暂时只做了前面的热评和一些最新的评论）
	* 查看up粉丝数、视频播放量、弹幕数量、收藏等
	* 点击右上角可以保存封面到相册
* 频道
	* 获取实时频道列表
* 动态
	* 动态界面
* 会员购
	* 显示活动和商品列表
	* 下拉刷新，加载更多
* 我的
	* 显示头像，昵称、等
	* 设置界面
	* 简单登陆界面和彩蛋

# 项目演示
视频：[bilibili](https://www.bilibili.com/video/av68687797)

# 界面截图
-----------------------------
|                             截图                             |
| :----------------------------------------------------------: |
|             启动/home/频道/动态/会员购/侧滑菜单              |
| ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190922192030995.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70) |
|                                                              |
|                    视频播放/评论/直播播放                    |
| ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190922192905429.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70) |
| |
|                           弹幕功能                           |
|   ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191020165918932.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70)      ![在这里插入图片描述](https://img-blog.csdnimg.cn/20191020165943119.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70)|
| |
|                     直播/热门/追番/影视                      |
| ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190922193826741.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70) |
|                                                              |
|                         影视/70周年                          |
| ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190922194042262.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70) |
|                                                              |
|                      搜索/登陆/保存封面                      |
| ![在这里插入图片描述](https://img-blog.csdnimg.cn/20190922194522476.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L3UwMTM1MTgwNjQ=,size_16,color_FFFFFF,t_70) |



# 上手指南
--------------
仅在安卓虚拟机Nexus_5X_API_24、华为荣耀6、华为荣耀9上测试通过
### 1.直接下载
安卓:[下载apk安装包](https://raw.githubusercontent.com/nekomiyaxneko/flutter_MyBilibili/master/release/app-release.apk)
IOS：由于没有ios开发设备，暂未提供

### 2.clone本项目
版本：
```
flutter: 1.9.1+hotfix.2-stable
```
1. clone本项目到本地 
```bash
git clone https://github.com/nekomiyaxneko/flutter_MyBilibili.git
```
2. 安装[flutter](https://flutter.dev/docs/get-started/install)
3. 在项目根目录打开命令行输入
```bash
flutter packages get 
flutter run --release
```

# TODO
--------------------------
- [ ] 视频下载功能

# 组件依赖
  视频播放： `chewie video_player`  
  打开url：`url_launcher`  
  轮播图：`flutter_swiper`  
  下拉刷新上滑加载：`pull_to_refresh`  
  数据持久化：`shared_preferences`  
  保存图片：`image_gallery_saver`  
  发送请求：`dio`  
  权限检查与申请：`permission_handler`  
  提示框：`fluttertoast`  
  分享：`share`  
  加载html：`flutter_widget_from_html`  


# 鸣谢
[《Flutter技术入门与实战》亢少军](https://blog.csdn.net/kangshaojun888)  

[BiliBili Android第三方](https://www.jianshu.com/p/5087346d8e93)  

[Bilibili播放地址](https://blog.csdn.net/ucsheep/article/details/89394700) 

[flutter-go](https://github.com/alibaba/flutter-go) 

# 维护
本项目不定期持续维护，欢迎各位提出建设性的建议。

# 版权声明
[MIT License ](LICENSE)
