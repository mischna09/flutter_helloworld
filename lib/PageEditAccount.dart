import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:helloworld/custom/LoadingDialog.dart';
import 'module/Util.dart';

class PageEditAccount extends StatefulWidget {
  PageEditAccount({Key? key,required this.selectId}):super(key:key);
  final int selectId;

  @override
  State<StatefulWidget> createState() {
    return _PagePageEditAccountState();
  }
}
class _PagePageEditAccountState extends CustomState<PageEditAccount>{
  var editAccount = TextEditingController();
  var editPassword = TextEditingController();
  String textAccount = "";
  String textPassword = "";
  bool isBtnSubmitEnable = false;

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 0), () {
      LoadingDialog().showDialogAndWait(context, dioGetData());
    });
  }

  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }

  Scaffold pageMain(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("修改資料")),
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("帳號: $textAccount"),
                        Text("密碼: $textPassword"),
                        TextField(
                          controller: editAccount,
                          decoration: InputDecoration(
                              labelText: '帳號',
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(8))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:20),
                          child: TextField(
                            controller: editPassword,
                            decoration: InputDecoration(
                                labelText: '密碼',
                                border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(8))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    CheckboxListTile(
                      title: Text("確認無誤，準備送出資料",style: TextStyle(color: Colors.black45)),
                        value: isBtnSubmitEnable,
                        onChanged:(value)=> refreshUI(() => {isBtnSubmitEnable = value!}),
                        controlAffinity: ListTileControlAffinity.leading,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: isBtnSubmitEnable ? ()=>
                                LoadingDialog().showDialogAndWait(context,dioSubmit()):null,
                            child: Text("提交")
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> dioSubmit() async {
    var formData = FormData.fromMap({
      'id': widget.selectId,
      'account': editAccount.text,
      'password': editPassword.text,
    });
    var response = await dioPostRequest("flutter/set_account_by_id.php",formData);
    switch(response['code']){
      case 100: makeToast("提交失敗，請再試一次");break;
      case 200: makeToast("修改成功");endPage();break;
    }
  }

  void endPage() async{
    await Future.delayed(const Duration(milliseconds: 800));
    Navigator.pop(context);
  }

  Future<void> dioGetData() async {
    var formData = FormData.fromMap({
      'id': widget.selectId,
    });
    var response = await dioPostRequest("flutter/get_account_by_id.php",formData);
    if(response == null) return;
    var data = response['data'];
    refreshUI(() {
      textAccount = data['account'];
      textPassword = data['password'];
      editAccount.text = data['account'];
      editPassword.text = data['password'];
    });
  }
}