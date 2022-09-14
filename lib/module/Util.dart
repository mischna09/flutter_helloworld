import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BaseDio.dart';

class CustomState<T extends StatefulWidget> extends State<T>{
  /* 網路請求 */
  var dio = BaseDio.getInstance();

  /* Toast */
  void makeToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<dynamic> startNewPage(BuildContext context, StatefulWidget page) async {
    Navigator.push(context,MaterialPageRoute(
        builder: (context) => page));
  }

  void refreshUI(VoidCallback? fn){
    /* 檢查頁面是否還在，否則會造成記憶體洩漏 */
    if(mounted) {
      setState(() => fn?.call());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text("Not implement");
  }
}
/*class Util{
  /* 網路請求 */
  var dio = BaseDio.getInstance();

  /* Toast */
  void makeToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.lightBlue,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

  Future<dynamic> startNewPage(BuildContext context, StatefulWidget page) async {
    Navigator.push(context,MaterialPageRoute(
        builder: (context) => page));
  }
}*/