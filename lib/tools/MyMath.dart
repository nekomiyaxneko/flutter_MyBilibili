import 'dart:math';
class MyMath{
  static String getrandomhash(){
    String alphabet = 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM';
    int strlenght = 30; /// 生成的字符串固定长度
    String left = '';
    for (var i = 0; i < strlenght; i++) {
      // right = right + (min + (Random().nextInt(max - min))).toString();
      left = left + alphabet[Random().nextInt(alphabet.length)];
    }
    return left;
  }

  static String intToString(int n){
    if (n > 10000) {
      return (n / 10000).toStringAsFixed(1)+"万";
    } else {
      return n.toString();
    }
  }
}