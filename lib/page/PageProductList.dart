import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/page/PageAccountList.dart';
import 'PageMainMenu.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;

/*  第一頁  */
class Page1{
  Page1(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(8, (index) => index);
  StatefulWidget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => mainItem(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainItem(int index) {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text("#$index"),
            subtitle: const Text("測試測試"),
            //trailing: Icon(Icons.arrow_forward_ios_outlined),
            trailing: const Icon(Icons.edit),
            contentPadding: const EdgeInsets.all(16),
            selected: index % 4 == 0,
            onTap: () => print("$index"),
          ),
          itemContent(),
          itemContent(),
        ],
      ),
    );
    return widget;
  }
  Widget itemContent(){
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3.6 進度指示器",style: Theme.of(parent.context).textTheme.bodyText1,),
                Text("第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。",style: Theme.of(parent.context).textTheme.caption,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
/*  第二頁  */
class Page2{
  Page2(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(3, (index) => index);
  var listFav = List<bool>.generate(3, (index) => false);
  StatefulWidget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("第二頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 2)),
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
                    child: const Text("Add")
                ),
                ElevatedButton(
                    onPressed: () {
                      list.removeAt(0);
                      parent.refreshUI(null);
                      print("$list");
                    },
                    child: const Text("Remove")
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
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.directions_car),
            title: const Text("文章標題"),
            subtitle: const Text("分類"),
            trailing: IconButton(
              icon: Icon(listFav[index] ? Icons.favorite:Icons.favorite_border),
              onPressed: () {
                listFav[index] = !listFav[index];
                parent.refreshUI(null);
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(16,16,16,8),
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
class Page3 {
  Page3(this.parent);
  final PageMainMenuState parent;

  final GlobalKey<AnimatedListState> _listKey = GlobalKey();


  Widget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("頁3"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: ()=> parent.startNewPage(PageAccountList()),
                  child: const Text("帳號列表")
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()=> parent.startNewPage(Page1(parent).page()),
                  child: const Text("樣式一")
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()=> parent.startNewPage(Page2(parent).page()),
                  child: const Text("樣式二")
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()=> parent.startNewPage(Page4(parent).page()),
                  child: const Text("樣式三")
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()=> parent.startNewPage(Page5(parent).page()),
                  child: const Text("樣式四")
                ),
              ),
              Container(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: ()=> parent.startNewPage(Page7(parent).page()),
                  child: const Text("文字編輯")
                ),
              ),
            ],
          ),
        )
      ),
    );
  }
}
/*  換行列表  */
class Page4{
  Page4(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(100, (index) => index);
  var listFav = List<bool>.generate(100, (index) => false);
  StatefulWidget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                child: GridView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => mainItem(index),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      //crossAxisSpacing: 5,
                      //childAspectRatio: 1.5
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget mainItem(int index) {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.directions_car),
            title: const Text("文章標題"),
            subtitle: const Text("分類"),
            contentPadding: const EdgeInsets.fromLTRB(16,0,16,0),
            selected: listFav[index],
            onTap: () => print("$index"),
          ),
          /*Image.network(
            "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png",
            fit: BoxFit.contain,
          ),*/
        ],
      ),
    );
    return widget;
  }
}

/*  第五頁  */
class Page5{
  Page5(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(8, (index) => index);
  StatefulWidget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [

              Text("熱門",style: Theme.of(parent.context).textTheme.headline5),
              itemHead(),

              Container(
                height: 200,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return Text("$index");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mainItem(int index) {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: Text("#$index"),
            subtitle: const Text("測試測試"),
            //trailing: Icon(Icons.arrow_forward_ios_outlined),
            trailing: const Icon(Icons.edit),
            contentPadding: const EdgeInsets.all(16),
            selected: index % 4 == 0,
            onTap: () => print("$index"),
          ),
          itemContent(),
        ],
      ),
    );
    return widget;
  }
  Widget itemContent(){
    return Column(
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("3.6 進度指示器",style: Theme.of(parent.context).textTheme.bodyText1,),
                Text("第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。",style: Theme.of(parent.context).textTheme.caption,),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget itemHead() {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [

          ListTile(
            //title: Text("3.6 進度指示器",style: Theme.of(parent.context).textTheme.headlineSmall),
            subtitle: const Text("第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"),
            trailing: const Icon(Icons.edit),
            contentPadding: const EdgeInsets.all(16),
            onTap: () => print("157"),
          ),
        ],
      ),
    );
    return widget;
  }
}
/*  第一頁  */
class Page6{
  Page6(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(1, (index) => index);
  StatefulWidget page() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => Future.delayed(const Duration(seconds: 2)),
                child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => mainItem(index),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainItem(int index) {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle,size: 40,),
            title: Text("Flutter基本元件"),
            subtitle: const Text("王曉明"),
            //trailing: Icon(Icons.arrow_forward_ios_outlined),
            trailing: const Icon(Icons.edit),
            contentPadding: const EdgeInsets.all(16),
            //selected: index % 4 == 0,
            onTap: () => print("$index"),
          ),
          itemContent(
            "1.1 進度指示器",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),
          /*itemContent(
            "1.2 AfterLayout",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),
          itemContent(
            "1.3 AfterLayout",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),
          itemContent(
            "1.4 AfterLayout",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),
          itemContent(
            "1.5 AfterLayout",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),
          itemContent(
            "1.6 AfterLayout",
            "第一個進度條在執行循環動畫：藍色條一直在移動，而第二個進度條是靜止的，停在50%的位置。"
          ),*/
        ],
      ),
    );
    return widget;
  }
  Widget itemContent(title,subtitle){
    return Column(
      children: [
        const Divider(),
        ListTile(
          //title: Text(title,style: Theme.of(parent.context).textTheme.bodyText1,),
          subtitle: Text(subtitle,style: Theme.of(parent.context).textTheme.caption,),
          dense: true,

          //contentPadding: const EdgeInsets.all(4),
          //selected: index % 4 == 0,
          onTap: () => print("111"),
        ),
        SizedBox(height: 8,),
        /*Padding(
          padding: const EdgeInsets.all(8),
          child: Align(
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,style: Theme.of(parent.context).textTheme.bodyText1,),
                Text(subtitle,style: Theme.of(parent.context).textTheme.caption,),
              ],
            ),
          ),
        ),*/
      ],
    );
  }
}
/*  文字編輯  */
class Page7{
  Page7(this.parent);
  final PageMainMenuState parent;

  List<int> list = List<int>.generate(1, (index) => index);
  Quill.QuillController _controller = Quill.QuillController.basic();
  late Quill.QuillController _controller2;


  StatefulWidget page() {
    var data = [{"insert":"Hdbsjsk"},{"insert":"\n","attributes":{"header":1}},{"insert":"Sheet"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Shake"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Djdjdjdxi","attributes":{"color":"#ef5350"}},{"insert":"\n","attributes":{"list":"ordered"}}];
    var json = jsonEncode(data);
    _controller2 = Quill.QuillController(
        document: Quill.Document.fromJson(jsonDecode(json)),
        selection: const TextSelection.collapsed(offset: 0)
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("首頁"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                child: Quill.QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            Divider(),
            Expanded(
              child: Container(
                child: Quill.QuillEditor.basic(
                  controller: _controller2,
                  readOnly: false,
                ),
              ),
            ),
            OutlinedButton(
              onPressed: (){
                var json = jsonEncode(_controller.document.toDelta().toJson());
                print("ENCODE JSON: $json");
                print("-----------------");
                /*var myJSON = Quill.Document.fromJson(jsonDecode(json));
                parent.refreshUI((){
                  _controller2 = Quill.QuillController(
                      document: myJSON,
                      selection: const TextSelection.collapsed(offset: 0)
                  );
                });*/
              },
              child: Text("JSON")
            ),
            Quill.QuillToolbar.basic(controller: _controller),
          ],
        ),
      ),
    );
  }
}