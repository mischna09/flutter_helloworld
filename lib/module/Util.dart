import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BaseDio.dart';

class CustomState<T extends StatefulWidget> extends State<T>{

  /* 網路請求 */
  Future<dynamic> dioPostRequest(String URL, FormData? formData) async {
    try {
      var response = await BaseDio.getInstance().post(URL,data: formData,);
      if (kDebugMode) {
        print("原始資料: ${response.data}");
      }
      return jsonDecode(response.data);
    } on DioError catch(error){
      switch(error.type){
        case DioErrorType.connectTimeout:
          makeToast("連線逾時，請稍後重試");
          break;
        case DioErrorType.sendTimeout:
        case DioErrorType.receiveTimeout:
        case DioErrorType.response:
        case DioErrorType.other:
          makeToast("網路異常，請稍後重試");
          break;
        case DioErrorType.cancel:
          makeToast("已取消");
          break;
      }
      return null;
    }
  }

  /* Toast */
  makeToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Theme.of(context).primaryColorDark,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  startNewPage(StatefulWidget page) async{
    await Future.delayed(const Duration(milliseconds: 200));
    if(mounted) Navigator.push(context,MaterialPageRoute(builder: (context) => page));
  }

  refreshUI(VoidCallback? fn){
    /* 檢查頁面是否還在，否則會造成記憶體洩漏 */
    if(mounted) setState(() => fn?.call());
  }

  @override
  Widget build(BuildContext context) {
    return Text("Not implement");
  }
}