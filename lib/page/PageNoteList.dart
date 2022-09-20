import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/custom/LoadingDialog.dart';
import 'package:helloworld/module/UserData.dart';
import '../module/Util.dart';
import 'package:flutter_quill/flutter_quill.dart' as Quill;

class PageNoteList extends StatefulWidget {
  const PageNoteList({super.key});

  @override
  State<StatefulWidget> createState() {
    return PageNoteListState();
  }
}

class PageNoteListState extends CustomState<PageNoteList> {
  /*var titleList = [
    "標題一",
    "二標題",
    "三三三",
  ];
  var subTitleList = [
    "內文內文",
    "內文二",
    "一二三",
  ];
  var jsonList = [
    '[{"insert":"111"},{"insert":"\n","attributes":{"header":1}},{"insert":"Sheet"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Shake"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Djdjdjdxi","attributes":{"color":"#ef5350"}},{"insert":"\n","attributes":{"list":"ordered"}}]',
    '[{"insert":"222"},{"insert":"\n","attributes":{"header":1}},{"insert":"Sheet"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Shake"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Djdjdjdxi","attributes":{"color":"#ef5350"}},{"insert":"\n","attributes":{"list":"ordered"}}]',
    '[{"insert":"333"},{"insert":"\n","attributes":{"header":1}},{"insert":"Sheet"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Shake"},{"insert":"\n","attributes":{"list":"ordered"}},{"insert":"Djdjdjdxi","attributes":{"color":"#ef5350"}},{"insert":"\n","attributes":{"list":"ordered"}}]',
  ];*/
  var indicator = GlobalKey<RefreshIndicatorState>();
  List<NoteData> dataList = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      indicator.currentState?.show();
    });
    //dataList = List<NoteData>.generate(3, (index) => NoteData(titleList[index], subTitleList[index], jsonList[index]));
  }

  @override
  Widget build(BuildContext context) {
    return pageMain();
  }

  Widget pageMain() {
    return Scaffold(
      appBar: AppBar(
        title: const Text("記事本"),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: RefreshIndicator(
              key: indicator,
              onRefresh: () => dioGetNoteList(),
              child: ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index)=> itemList(index),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await startNewPage(_PageEditNote(
              data: NoteData(
                  "筆記名稱",
                  DateTime.now().toString().split(".")[0],
                  ""
              )));
          indicator.currentState?.show();
        },
        tooltip: '新增筆記',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget itemList(int index) {
    var widget = Card(
      margin: const EdgeInsets.all(8),
      //color: index%2 == 0 ? Theme.of(context).primaryColorLight:Theme.of(context).primaryColorDark,
      child: Column(
        children: [
          ListTile(
            //leading: Icon(Icons.directions_car),
            title: Text("${dataList[index].title}"),
            subtitle: Text(dataList[index].subtitle),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                //LoadingDialog().showDialogAndWait(context, dioAddNote(dataList[index]));
                //startNewPage(_PageEditNote(data: dataList[index]));
              },
            ),
            contentPadding: const EdgeInsets.fromLTRB(16,16,16,8),
            onTap: () async {
              await startNewPage(_PageEditNote(data: dataList[index]));
              print("關掉頁面，執行刷新");
              indicator.currentState?.show();
            },
          ),
        ],
      ),
    );
    return widget;
  }
  
  /* 取得此帳號筆記 */
  Future<void> dioGetNoteList() async {
    var formData = FormData.fromMap({
      'account': UserData.account,
    });
    var response = await dioPostRequest("flutter/note/get_note_by_account.php",formData);
    if(response == null) return;

    var code = response['code'];
    if(code == 200){
      List<dynamic> data = response['data'];
      List<NoteData> resultList = [];
      data.forEach((element) {
        NoteData note = NoteData(element['title'], element['subtitle'], element['contentJson']);
        note.id = element['id'];
        resultList.add(note);
      });
      dataList = resultList;
      refreshUI(null);
    }
  }
}

/* 筆記編輯 */
class _PageEditNote extends StatefulWidget {
  const _PageEditNote({Key? key,required this.data}):super(key:key);
  final NoteData data;

  @override
  State<StatefulWidget> createState() {
    return _PageEditNoteState();
  }
}

class _PageEditNoteState extends CustomState<_PageEditNote> {
  late NoteData data;
  late Quill.QuillController _editContent;
  late TextEditingController _editTitle;
  late TextEditingController _editSubtitle;

  @override
  void initState() {
    super.initState();
    data = widget.data;
    _editTitle = TextEditingController(text: data.title);
    _editSubtitle = TextEditingController(text: data.subtitle);
    if(data.contentJson == ""){
      _editContent = Quill.QuillController.basic();
      return;
    }
    //contentJson只會被解碼成String，因此再解碼一次，並替換換行符號
    List<dynamic> json = jsonDecode(data.contentJson);
    json.forEach((element) {
      element['insert'] = element['insert'].replaceAll("NEWLINE", "\n");
    });
    _editContent = Quill.QuillController(
        document: Quill.Document.fromJson(json),
        selection: const TextSelection.collapsed(offset: 0)
    );
  }

  @override
  void dispose() {
    _editTitle.dispose();
    _editSubtitle.dispose();
    _editContent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return pageMain();
  }

  Widget pageMain() {
    return WillPopScope(
      onWillPop: () async => await Future.delayed(Duration(seconds: 1),() => true),
      child: Scaffold(
        appBar: AppBar(
          title: Text("筆記編輯"),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: (){
                if(_editTitle == ""){
                  makeToast("標題不能為空.");
                  return;
                }
                data.title = _editTitle.text;
                data.subtitle = _editSubtitle.text;
                data.contentJson = jsonEncode(_editContent.document.toDelta().toJson());
                if(data.id == "") LoadingDialog().showDialogAndWait(context, dioAddNote(data));
                else LoadingDialog().showDialogAndWait(context, dioUpdateNote(data));
              },
              tooltip: "儲存至雲端",
              icon: Icon(Icons.save),
            ),
          ],
        ),
        body: Column(
          children: [
            TextField(
              controller: _editTitle,
              style: Theme.of(context).textTheme.headline6,
              decoration: const InputDecoration(
                prefixText: "標題：",
                prefixStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0x66000000),
                ),
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
              ),
            ),
            TextField(
              controller: _editSubtitle,
              style: Theme.of(context).textTheme.headline6,
              decoration: const InputDecoration(
                prefixText: "副標：",
                prefixStyle: TextStyle(
                  fontSize: 16,
                  color: Color(0x66000000),
                ),
                contentPadding: EdgeInsets.all(12),
                border: InputBorder.none,
              ),
            ),
            const Divider(color: Color(0x88000000),),
            Quill.QuillToolbar.basic(
              controller: _editContent,
              toolbarIconAlignment: WrapAlignment.start,
              showUndo: false,
              showRedo: false,
              showClearFormat: false,
              //showQuote: false,
              showInlineCode: false,
              showJustifyAlignment: false,
              showCodeBlock: false,
              showFontFamily: false,
              showFontSize: false,
              showSearchButton: false,
              showLink: false,
            ),
            const Divider(color: Color(0x88000000),),
            Expanded(
              child: Quill.QuillEditor.basic(
                controller: _editContent,
                readOnly: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
  /* 上傳筆記 */
  Future<void> dioAddNote(NoteData data) async {
    var formData = FormData.fromMap({
      'account': UserData.account,
      'title': data.title,
      'subtitle': data.subtitle,
      'contentJson': data.contentJson.replaceAll("\n", "NEWLINE"),
    });
    var response = await dioPostRequest("flutter/note/add_note_by_account.php", formData);
    if(response == null) return;

    switch(response['code']){
      case 100: print("上傳失敗");break;
      case 200: {
        makeToast("儲存成功");
        data.id = response['data']['id'].toString();
        break;
      }
    }
  }
  /* 更新筆記 */
  Future<void> dioUpdateNote(NoteData data) async {
    var formData = FormData.fromMap({
      'id': data.id,
      'title': data.title,
      'subtitle': data.subtitle,
      'contentJson': data.contentJson.replaceAll("\n", "NEWLINE"),
    });
    var response = await dioPostRequest("flutter/note/update_note_by_id.php", formData);
    if(response == null) return;

    switch(response['code']){
      case 100: print("更新失敗");break;
      case 200: {
        makeToast("儲存成功");
        break;
      }
    }
  }
}
class NoteData{
  NoteData(this.title,this.subtitle,this.contentJson);
  String id = "";
  String title;
  String subtitle;
  String contentJson;
}