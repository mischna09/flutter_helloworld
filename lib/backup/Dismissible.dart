import 'package:flutter/material.dart';

import '../module/Util.dart';

class _Page2 {
  _Page2(this.parent);
  final CustomState<StatefulWidget> parent;
  List<int> list = List<int>.generate(5, (index) => index);

  Widget page() {
    return Scaffold(
      appBar: AppBar(
        title: Text("首頁2"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    Future.delayed(Duration(seconds: 1), () => parent.refreshUI(null)),
                child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                          key: UniqueKey(),
                          onDismissed: (direction) {
                            list.removeAt(index);
                          },
                          child: ListTile(title: Text("@$index")));
                    }),
              ),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      list.add(101);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: Text("Add")
                ),
                Text("大小:${list.length}"),
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