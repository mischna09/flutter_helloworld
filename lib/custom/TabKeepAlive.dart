import 'package:flutter/material.dart';

class TabKeepAlive extends StatefulWidget{
  const TabKeepAlive({super.key, required this.child,});
  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _TabKeepAlive();
  }
}

class _TabKeepAlive extends State<TabKeepAlive>  with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }
  @override
  bool get wantKeepAlive => true;
}
