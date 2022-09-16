import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/PageAccountList.dart';
import 'package:helloworld/backup/TestPage.dart';
import 'custom/TabKeepAlive.dart';
import 'module/Util.dart';

class PageMainMenu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageMainMenuState();
  }
}

class _PageMainMenuState extends CustomState<PageMainMenu> {
  late final _Page1 page1;
  late final _Page2 page2;
  late final _Page3 page3;
  @override
  void initState() {
    super.initState();
    page1 = _Page1(this);
    page2 = _Page2(this);
    page3 = _Page3(this);
  }

  @override
  Widget build(BuildContext context) {
    return pageMain();
  }

  Widget pageMain() {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: TabBarView(
          children: [
            TabKeepAlive(child: page1.page()),
            TabKeepAlive(child: page2.page()),
            TabKeepAlive(child: page3.page()),
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
/*  第一頁  */
class _Page1{
  _Page1(this.parent);
  final _PageMainMenuState parent;

  List<int> list = List<int>.generate(8, (index) => index);
  Widget page() {
    return Scaffold(
      appBar: AppBar(
        title: Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(Duration(seconds: 2)),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => mainItem(index),
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      //list.removeAt(0);
                      list = List.from(list);
                      list.add(list.length+1);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: Text("Add")
                ),
                ElevatedButton(
                    onPressed: () {
                      list.removeAt(0);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: Text("Remove")
                ),
                Text("大小:${list.length}")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget mainItem(int index) {
    var widget = Card(
      margin: EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.directions_car),
            title: Text("#$index"),
            subtitle: Text("測試測試"),
            trailing: Icon(Icons.arrow_forward_ios_outlined),
            contentPadding: EdgeInsets.all(16),
            selected: index % 4 == 0,
            onTap: () => print("$index"),
          ),
          //Text("#$index"),
        ],
      ),
    );
    return widget;
  }
}
/*  第二頁  */
class _Page2{
  _Page2(this.parent);
  final _PageMainMenuState parent;

  List<int> list = List<int>.generate(8, (index) => index);
  var listFav = List<bool>.generate(8, (index) => false);
  Widget page() {
    return Scaffold(
      appBar: AppBar(
        title: Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(Duration(seconds: 2)),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => mainItem(index),
                ),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      //list.removeAt(0);
                      list = List.from(list);
                      list.add(list.length+1);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: Text("Add")
                ),
                ElevatedButton(
                    onPressed: () {
                      list.removeAt(0);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: Text("Remove")
                ),
                Text("大小:${list.length}")
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget mainItem(int index) {
    var widget = Card(
      margin: EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.directions_car),
            title: Text("文章標題"),
            subtitle: Text("分類"),
            trailing: IconButton(
              icon: Icon(listFav[index] ? Icons.favorite:Icons.favorite_border),
              onPressed: () {
                listFav[index] = !listFav[index];
                parent.refreshUI(null);
              },
            ),
            contentPadding: EdgeInsets.fromLTRB(16,16,16,8),
            selected: listFav[index],
            onTap: () => print("$index"),
          ),
          //Divider(),
          /*Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(child: Text("留言")),
                Expanded(child: Text("留言")),
                Expanded(child: Text("分享")),
              ],
            ),
          )*/
        ],
      ),
    );
    return widget;
  }
}
/*  第三頁  */
class _Page3 {
  _Page3(this.parent);
  final _PageMainMenuState parent;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();


  Widget page() {
    return Scaffold(
      appBar: AppBar(
        title: Text("頁3"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: animWidget()
        )
      ),
    );
  }
  animWidget(){
    Widget widget = Container(
      width: 100,
      height: 100,
      color: Theme.of(parent.context).primaryColor,
    );
    return widget;
  }
}
