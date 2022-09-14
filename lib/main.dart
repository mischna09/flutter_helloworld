import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/PageAccountList.dart';
import 'package:helloworld/PageRegister.dart';
import 'package:helloworld/dataClass/article.dart';

import 'PageMainMenu.dart';
import 'module/BaseDio.dart';
import 'module/Util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /* TODO 主題顏色，可以讓用戶設定 */
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends CustomState<MyHomePage>{
  int _counter = 0;
  var editAccount = TextEditingController();
  var editPassword = TextEditingController();

  /* TODO 首頁畫面重構，安全比例 */

  Future<void> dioGetArticleList() async {
    var formData = FormData.fromMap({
      'account': editAccount.text,
      'password': editPassword.text,
    });
    var response = await BaseDio.getInstance().post(
        "flutter/login.php",
        data: formData
    );
    print("原始資料: ${response.data}");
    var json = jsonDecode(response.data);
    var article = Article.fromJson(json);
    print("回傳結果: ${article.code}");
    switch(article.code){
      case 100: print("登入失敗");break;
      case 200: print("登入成功");break;
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return secondBackup(context);
  }

  Widget secondBackup(BuildContext context){
    return Scaffold(
        appBar: AppBar(
            title: Text("Hello World"),
        ),
        body: SafeArea(
          /* 手勢感測，點畫面其他地方取消focus，提升UX */
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: double.infinity,
              decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
              child: Stack(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 24),
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10,
                              color: Color(0x4D000000),
                              offset: Offset(0, 2),
                            )
                          ],
                          border: Border.fromBorderSide(BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.0,
                          )),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.flutter_dash,
                          size: 140,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                        //height: MediaQuery.of(context).size.height*0.5,
                        //width: MediaQuery.of(context).size.width*0.5,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            shape: BoxShape.rectangle,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                color: Color(0x4D000000),
                                offset: Offset(0, 2),
                              ),
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              TextField(
                                controller: editAccount,
                                decoration: InputDecoration(
                                    labelText: '帳號',
                                    //hintText: "請輸入帳號",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(8))),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: TextField(
                                  obscureText: true,
                                  controller: editPassword,
                                  decoration: InputDecoration(
                                      labelText: '密碼',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8))),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  RichText(
                                      text: TextSpan(
                                          text: "忘記密碼",
                                          style: const TextStyle(
                                              color: Colors.blue),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              print("忘記密碼");
                                            }))
                                ],
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: ElevatedButton(
                                  onPressed: () {
                                    startNewPage(context, PageMainMenu());
                                    //LoadingDialog().showDialogAndWait(context, dioGetArticleList());
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text("登入"),
                                    ],
                                  ),
                                ),
                              ),
                              OutlinedButton(
                                onPressed: ()=> startNewPage(context, PageRegister()) ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("註冊"),
                                  ],
                                ),
                              ),
                              OutlinedButton(
                                onPressed: ()=> startNewPage(context, PageAccountList()) ,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Text("直接登入"),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "2022/9/13",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  Widget firstBackup(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const[
            Icon(Icons.connected_tv_sharp),
            Text("Hello World")
          ],
        )
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height*0.5,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
              topLeft: Radius.circular(0),
              topRight: Radius.circular(0),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text("帳號"),
                ),
                ElevatedButton(onPressed: (){print("Click");}, child: const Text("Button2")),
                OutlinedButton(onPressed: (){print("Click");}, child: const Text("Button2")),
                ToggleButtons(
                  isSelected: const [
                    false,
                    true,
                    false
                  ],
                  selectedColor: Colors.blue,
                  children: const [
                    Text("123"),
                    Text("234"),
                    Text("345"),],
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          blurRadius: 5,
                          color: Color(0x4D000000),
                          offset: Offset(0,2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(8),
                      shape: BoxShape.rectangle,
                    ),
                    child : Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: const [

                            Expanded(
                              child: Text(
                                    "1",
                                    textAlign: TextAlign.end,
                                ),
                            ),
                            Expanded(
                              child: Text("1"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  Scaffold systemDemo(){
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround ,
          children: [
            Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times2:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("123"),
                Text("321")
              ],
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}