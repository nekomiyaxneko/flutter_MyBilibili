
import 'package:event_bus/event_bus.dart';
EventBus danmakuEventBus = EventBus();
class DanmakuStatus{
  static int play=10;
  static int pause=11;
  static int setStatus=1;
  static int goto=2;
  static int setDuration=3;
  String msg;
  int status;
  int cmd;
  int param;
  DanmakuStatus({this.status,this.msg,this.param,this.cmd});
}
