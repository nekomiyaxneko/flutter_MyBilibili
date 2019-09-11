import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AssetImage inputaccountlogo=AssetImage("images/login_logo_account.png");
  final AssetImage inputpasswordlogo=AssetImage("images/login_logo_password.png");
  final FocusNode _passwordfocusnode=FocusNode();
  AssetImage logo;
  String account="";
  String password="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    logo=inputaccountlogo;
    _passwordfocusnode.addListener(_passwordListener);
  }
  Future<Null> _passwordListener()async {//当光标在密码栏时切换logo
    if(_passwordfocusnode.hasFocus){
      logo=inputpasswordlogo;
      setState(() {
      });
    }
    if(!_passwordfocusnode.hasFocus){
      logo=inputaccountlogo;
      setState(() {
      });
    }
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登陆"),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.fromLTRB(10, 10, 15, 10),
            child: Text("忘记密码?"),
          ),
        ],
      ),
      resizeToAvoidBottomPadding: false,//防止软键盘弹出而超出范围
      body: Container(
        color: Color.fromRGBO(234,234, 234, 1),
        //rgb:234,234,234
        child: Column(
              children: <Widget>[
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: logo),
                  ),
                ),
                Container(//账号输入框
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    controller: TextEditingController.fromValue(TextEditingValue(
                      text: account,
                      selection: TextSelection.fromPosition(//保持光标在最后面
                        TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: account.length,
                        ),
                      ),
                    )),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    obscureText: false,//是否是密码
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "你的手机号/邮箱",
                      icon: Icon(Icons.person_outline)
                    ),
                    onChanged: (text){
                      setState(() {
                        account=text;
                        print("account"+account);
                      });
                      
                    },
                    
                  ),
                ),
                Container(//密码输入框
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextField(
                    focusNode: _passwordfocusnode,
                    controller: TextEditingController.fromValue(TextEditingValue(
                      text: password,
                      selection: TextSelection.fromPosition(//保持光标在最后面
                        TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: password.length,
                        ),
                      ),
                    )),
                    maxLength: 16,
                    keyboardType: TextInputType.text,
                    obscureText: true,//是否是密码
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "请输入密码",
                      icon: Icon(Icons.lock)
                    ),
                    onChanged: (text){
                      setState(() {
                        password=text;
                        print("password "+password);
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton	(
                        child: Text("注册账号"),
                        borderSide: BorderSide(
                          color: Colors.pink[300],
                          width: 1,
                        ),
                        textColor: Colors.pink[300],
                        onPressed: (){

                        },
                        
                      ),
                      FlatButton	(
                        child: Text("登陆"),
                        color: Colors.pink[300],
                        textColor: Colors.white,
                        onPressed: _login,
                      ),
                    ],
                  ),
                ),
              ],
            ),
        
      ),
      
    );
  }
  void _login(){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('要是真的能登陆就好了',textAlign: TextAlign.center,),
        content: Container(
          height: 50,
          alignment: Alignment.center,
          child: new CircularProgressIndicator(
            strokeWidth: 2.0,
            backgroundColor: Colors.blue,
            // value: 0.2,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.pink[300]),
          ),
        ),
      )
    );

  }
}