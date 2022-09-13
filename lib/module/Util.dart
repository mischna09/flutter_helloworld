import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'BaseDio.dart';

class Util{
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

}