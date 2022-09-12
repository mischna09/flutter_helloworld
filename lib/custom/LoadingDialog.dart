import 'package:flutter/material.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';

class LoadingDialog{

  Future<void> showDialog(BuildContext context, Future func) async {
    var dialog = makeDialog(context);
    dialog.show();
    await func;
    dialog.dismiss();
  }

  ArsProgressDialog makeDialog(BuildContext context) {
    ArsProgressDialog dialog = ArsProgressDialog(context,
        //blur: 1,
        dismissable: false,
        backgroundColor: Color(0x4D000000),
        loadingWidget: Container(
          width: 200,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  strokeWidth: 6,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 28),
                child: Text("載入中..."),
              )
            ],
          ),
        ));
    return dialog;
  }
}

