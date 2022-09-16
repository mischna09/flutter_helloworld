import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/page/PageProductList.dart';
import '../custom/TabKeepAlive.dart';
import '../module/Util.dart';

class PageMainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PageMainMenuState();
  }
}

class PageMainMenuState extends CustomState<PageMainMenu> {
  late final Page6 page1;
  late final Page2 page2;
  late final Page3 page3;
  @override
  void initState() {
    super.initState();
    page1 = Page6(this);
    page2 = Page2(this);
    page3 = Page3(this);
  }

  @override
  Widget build(BuildContext context) {
    return pageMain();
  }

  Widget pageMain() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  TabKeepAlive(child: page1.page()),
                  TabKeepAlive(child: page2.page()),
                  TabKeepAlive(child: page3.page()),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          color: Theme.of(context).primaryColor,
          child: TabBar(
            indicator: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            labelPadding: EdgeInsets.all(12.0),
            tabs: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //Icon(Icons.directions_car),
                  Text("首頁"),
                ],
              ),
              Text("發文"),
              Text("個人資料"),
              //Tab(icon: Icon(Icons.directions_car)),
            ],
          ),
        ),
      ));
  }
}