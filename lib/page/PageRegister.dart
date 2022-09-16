import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/custom/ExpandToggleButtons.dart';
import 'package:dio/dio.dart';
import 'package:helloworld/custom/LoadingDialog.dart';
import '../module/Util.dart';

class PageRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageRegisterState();
  }
}
class _PageRegisterState extends CustomState<PageRegister>{

  final editAccount = TextEditingController();
  final editPassword = TextEditingController();
  final editPasswordAgain = TextEditingController();
  var dropdownValue = 'ABC';
  var choiceChipValue = 'AAA';
  var toggleButtonValue = 0;

  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }

  Scaffold pageMain(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text("註冊新會員")
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x4D000000),
                      offset: Offset(0,2),
                    ),
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    TextField(
                      controller: editAccount,
                      decoration: InputDecoration(
                          labelText: '帳號',
                          //hintText: "請輸入帳號",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        obscureText: true,
                        controller: editPassword,
                        decoration: InputDecoration(
                            labelText: '密碼',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        obscureText: true,
                        controller: editPasswordAgain,
                        decoration: InputDecoration(
                            labelText: '再次輸入密碼',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                    ),
                    //customToggle(),
                    ElevatedButton(
                      onPressed: () {
                        showCupertinoModalPopup(
                            context: context,
                            semanticsDismissible: true,
                            builder: (BuildContext context){
                              return Center(
                                child: CupertinoPicker(
                                    itemExtent: 45,
                                    backgroundColor: Colors.white,
                                    onSelectedItemChanged: (index){
                                      print("$index");
                                    },
                                    children: [
                                      Container(color: Colors.lightBlueAccent),
                                      Container(color: Colors.blueAccent),
                                      Container(color: Colors.lightBlue),
                                    ],
                                ),
                              );
                            },
                        );
                      },
                      child: Text("iOS風格選擇器"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        btnRegisterOnClick();
                      },
                      child: Text("註冊"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        LoadingDialog().showDialogAndWait(context, Future.delayed(Duration(seconds: 3)));
                        //LoadingDialog().showDialog(context, Future.delayed(Duration(seconds: 3)));
                      },
                      child: Text("載入框"),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  /*void showLoadingDialog(){
    //Source: https://book.flutterchina.club/chapter7/dailog.html#_7-7-5-%E5%85%B6%E4%BB%96%E7%B1%BB%E5%9E%8B%E7%9A%84%E5%AF%B9%E8%AF%9D%E6%A1%86
    showDialog(
      context: context,
      //barrierDismissible: false,
      builder: (context){
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
            width: 280,
            child: AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text("Loading..."),
                  )
                ],
              ),
            ),
          ),
        );
      }
    );
  }*/

  void btnRegisterOnClick(){
    if(editAccount.text == ''){
      makeToast("帳號未填寫");
      return;
    }
    if(editAccount.text.length < 6){
      makeToast("帳號至少要六個字元");
      return;
    }
    if(editPassword.text == ''){
      makeToast("密碼未填寫");
      return;
    }
    if(editPassword.text.length < 8){
      makeToast("帳號至少要八個字元");
      return;
    }
    if(editPassword.text != editPasswordAgain.text){
      makeToast("兩次密碼不相同");
      return;
    }
    //makeToast("註冊成功");
    LoadingDialog().showDialogAndWait(context, dioRegister());
    //LoadingDialog().showDialog(context, dioRegister() );
    //關閉葉面
  }

  Future<void> dioRegister() async {
    var formData = FormData.fromMap({
      'account': editAccount.text,
      'password': editPassword.text,
    });

    var response = await dioPostRequest("flutter/register.php",formData);
    if(response == null) return;
    switch(response['code']){
      case 100: makeToast("失敗100");break;
      case 200: makeToast("成功200");break;
      case 201: makeToast("此帳號已存在");break;
    }
    //TODO 註冊完關閉這個頁面
  }

  Container customToggle() {
    var size = 5;
    var widget = List.generate(5, (index) => Expanded(child: Text("#$index")));
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        /*children: [
          TextButton(onPressed: (){print("1");}, child: Text("1")),
          TextButton(onPressed: (){print("1");}, child: Text("1")),
          TextButton(onPressed: (){print("1");}, child: Text("1")),
        ],*/
        children: _textButton()
      ),
    );
  }

  List<Widget> _textButton(){
    var size = 3;

    return List.generate(3, (index) =>
        Expanded(
          child: TextButton(
              onPressed: (){print("$index");},
              child: Text("#$index")
          ),
        )
    );
  }

  ExpandToggleButtons _toggleButtons(){
    var size = 5;
    var widget = List.generate(size, (index) =>
            Text("#$index")
    );
    return ExpandToggleButtons(
      borderRadius: BorderRadius.circular(24),
      onPressed: (index){
        refreshUI(() {
          toggleButtonValue = index;
        });
      },
      isSelected: List.generate(size, (index) => index == toggleButtonValue),
      children: widget,
    );
  }

  ChoiceChip _choiceChip(String text, bool isSelected){
    return ChoiceChip(
      label: Text(text),
      selectedColor: Colors.blueAccent,
      disabledColor: Colors.greenAccent,
      onSelected: (bool value){
        refreshUI(() {
          choiceChipValue = text;
        });
      },
      selected: choiceChipValue == text,
    );
  }

  /* 用不太懂、而且不好看，暫時棄用 */
  /*DropdownButton _dropdownButton(){
    return DropdownButton<String>(
        value: dropdownValue,
        items: [
          _dropdownMenuItem("ABC"),
          _dropdownMenuItem("BBB"),
          _dropdownMenuItem("CCC"),
        ],
        onChanged: (val) {
          setState((){
            dropdownValue = val!;
            print("$val");
          });
        },
        hint: Text("123"),
    );
  }

  DropdownMenuItem<String> _dropdownMenuItem(String name){
    return DropdownMenuItem<String>(
      child: Text(name),
      value: name,
    );
  }*/
}