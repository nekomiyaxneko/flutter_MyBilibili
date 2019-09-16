import 'package:flutter/material.dart';

class BIcon {
  //等级
  static const List<IconData> level = [
    const _BIcon(0xe6cc),
    const _BIcon(0xe6cd),
    const _BIcon(0xe6ce),
    const _BIcon(0xe6cf),
    const _BIcon(0xe6d0),
    const _BIcon(0xe6d1),
    const _BIcon(0xe6d2),
  ];
  //等级颜色
  static  List<Color> levelColor=[
    Colors.grey[200],
    Colors.grey[300],
    Colors.green[300],
    Colors.blue[300],
    Colors.orange[300],
    Colors.deepOrange,
    Colors.red,
  ];
  //点赞
  static const zan =const _BIcon(0xe6c7);
  //踩
  static const cai =const _BIcon(0xe6c6);
  //分享
  static const share =const _BIcon(0xe671);
  //硬币
  static const icon=const _BIcon(0xe670);
  //收藏
  static const collection=const _BIcon(0xe673);
  static const collection_fill=const _BIcon(0xe674);
  //弹幕
  static const danmu_off=const _BIcon(0xe69c);
  static const danmu_on=const _BIcon(0xe69d);
  //购物
  static const shop=const _BIcon(0xe601);
  //播放量
  static const play=const _BIcon(0xe66d);
  //弹幕
  static const danmaku=const _BIcon(0xe66a);
  //搜索
  static const search=const _BIcon(0xe679);
  //播放-动作
  static const play_action=const _BIcon(0xe6b0);
  //全屏
  static const full_screen=const _BIcon(0xe678);
  //更多
  static const more=const _BIcon(0xe693);

}

class _BIcon extends IconData {
  const _BIcon(int codePoint)
      : super(codePoint, fontFamily: "Bilibili");
}
