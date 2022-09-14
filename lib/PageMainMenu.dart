import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PageAccountList.dart';
import 'custom/TabKeepAlive.dart';
import 'module/Util.dart';

class PageMainMenu extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageMainMenuState();
  }
}
class _PageMainMenuState extends CustomState<PageMainMenu>{

  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }

  Widget pageMain(BuildContext context){
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            TabKeepAlive(child: _Page1().page()),
            TabKeepAlive(child: _Page2().page()),
            TabKeepAlive(child: PageAccountList()),
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
              //Tab(icon: Icon(Icons.directions_train)),
              //Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
        ),
      )
    );
  }
}

class _Page1{
  Widget page(){
    return Scaffold(
      appBar: AppBar(
        title: Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("#1"),
            Text("#2"),
            Text("#3"),
          ],
        ),
      ),
    );
  }

  Widget mainItem(){
    var widget = Container(

    );
    return Text("");
  }
}
class _Page2{
  Widget page(){
    return Scaffold(
      appBar: AppBar(
        title: Text("發文"),
        automaticallyImplyLeading: false,
        centerTitle: true,
        //toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Text("#5"),
            Text("#6"),
            Text("#7"),
          ],
        ),
      ),
    );
  }
}