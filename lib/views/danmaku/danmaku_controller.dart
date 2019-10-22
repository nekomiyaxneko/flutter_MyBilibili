import 'dart:async';

import 'danmaku_item.dart';
import 'danmaku_status.dart';

class DanmakuController {
  List<DanmakuItem> danmakus;
  StreamSubscription _danmakuSubscription;
  int status;
  bool isPause(){
    return status==DanmakuStatus.pause;
  }
  bool isPlay(){
    return status==DanmakuStatus.play;
  }
  void pause() {
    danmakuEventBus.fire(DanmakuStatus(status: DanmakuStatus.pause,cmd: DanmakuStatus.setStatus));
  }
  
    ///duration毫秒
  void goto(int duration){
    danmakuEventBus.fire(DanmakuStatus(cmd: DanmakuStatus.goto,param: duration));
  }

  void play() {
    danmakuEventBus.fire(DanmakuStatus(status: DanmakuStatus.play,cmd: DanmakuStatus.setStatus));
  }
  void setDuration(int duration){
    danmakuEventBus.fire(DanmakuStatus(cmd: DanmakuStatus.setDuration,param: duration));
  }

  Future<void> dispose() async{
    await _danmakuSubscription?.cancel();
  }

  void init() {
    _danmakuSubscription = danmakuEventBus.on<DanmakuStatus>().listen((event) {
     // print("cmd ${event.cmd} param   ${event.param}");
      if(event.cmd==DanmakuStatus.setStatus){
        status = event.status;
      }
    });
  }

  DanmakuController(this.danmakus) {
    init();
  }
}
