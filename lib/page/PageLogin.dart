import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/module/UserData.dart';
import 'package:helloworld/page/PageRegister.dart';
import '../custom/LoadingDialog.dart';
import '../module/Util.dart';
import 'PageMainMenu.dart';

class PageLogin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageLoginState();
  }
}
class _PageLoginState extends CustomState<PageLogin>{
  var editAccount = TextEditingController();
  var editPassword = TextEditingController();

  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }
  @override
  void dispose() {
    editAccount.dispose();
    editPassword.dispose();
    super.dispose();
  }

  Widget pageMain(BuildContext context){
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Hello Flutter"),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
            child: Column(
              children: [
                widgetBirdIcon(),
                widgetLoginForm(),
                //Expanded(flex: 1,child: Container())
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetLoginForm(){
    return Container(
      margin: EdgeInsets.only(left: 24,right: 24),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          shape: BoxShape.rectangle,
          boxShadow: const [
            BoxShadow(
              blurRadius: 5,
              color: Color(0x4D000000),
              offset: Offset(0, 2),
            ),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: editAccount,
              decoration: InputDecoration(
                  labelText: '帳號',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(8))),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 20, bottom: 10),
              child: TextField(
                obscureText: true,
                controller: editPassword,
                decoration: InputDecoration(
                    labelText: '密碼',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(8))),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: RichText(
                text: TextSpan(
                  text: "忘記密碼",
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    startNewPage(PageMainMenu());
                    editAccount.text = "123";
                    editPassword.text = "1234";
                  }
                )
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(top: 10),
              child: ElevatedButton(
                onPressed: () {
                  LoadingDialog().showDialogAndWait(context, dioLogin());
                },
                child: Center(child: Text("登入")),
              ),
            ),
            OutlinedButton(
              onPressed: ()=> startNewPage(PageRegister()) ,
              child: Center(child: Text("註冊")),
            ),
          ],
        ),
      ),
    );
  }
  Widget widgetBirdIcon(){
    return Container(
      margin: const EdgeInsets.only(top: 20,bottom: 20),
      height: MediaQuery.of(context).size.height*0.2,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 10,
            color: Color(0x4D000000),
            offset: Offset(0, 2),
          )
        ],
        border: Border.fromBorderSide(BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1.0
        )),
        shape: BoxShape.circle
      ),
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Icon(
        Icons.flutter_dash,
        color: Theme.of(context).primaryColor,
      ),
      ),
    );
  }
  /*  網路請求  */
  Future<void> dioLogin() async {
    var formData = FormData.fromMap({
      'account': editAccount.text,
      'password': editPassword.text,
    });
    var response = await dioPostRequest("flutter/login.php", formData);
    if(response == null) return;

    switch(response['code']){
      case 100: print("登入失敗");break;
      case 200: {
        print("登入成功");
        UserData.account = editAccount.text;
        UserData.password = editPassword.text;
        startNewPage(PageMainMenu());
        break;
      }
    }
  }
}