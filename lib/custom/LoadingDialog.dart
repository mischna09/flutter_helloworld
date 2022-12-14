import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoadingDialog{
  //var animationDuration = const Duration(milliseconds: 300);
  //var dismissable = true;
  //var onDismiss;
  bool _isShowing = false;
  late final BuildContext context;

  Future<void> showDialogAndWait(BuildContext context, Future func) async {
    this.context = context;
    _makeDialog();
    await func;
    if (_isShowing) {
      if (kDebugMode) {
        print("Dialog: 載入框關閉。");
      }
      _isShowing = false;
      Navigator.pop(context);
    }
  }

  void _makeDialog() async{
    _isShowing = true;
    await showDialog(
        context: context,
        //barrierDismissible: false,
        builder: (context) => _dialogWidget()
    );
    _isShowing = false;
  }

  Widget _dialogWidget(){
    return Material(
      type: MaterialType.transparency,
      child: Container(
        color: Colors.black26,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 100,
                    width: 100,
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 14),
                    child: Text(
                      "載入中...",
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("強制關閉"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

