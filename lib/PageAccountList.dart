import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'PageEditAccount.dart';
import 'module/Util.dart';

class PageAccountList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageAccountListState();
  }
}
class _PageAccountListState extends CustomState<PageAccountList>{
  List<dynamic>  resultList = [];
  /* 紀錄所選的ID(mysql的索引)，供換頁時使用 */
  int selectId = -1;

  var indicator = GlobalKey<RefreshIndicatorState>();
  Widget? bottomWidget;

  @override
  void initState(){
    super.initState();
    Future.delayed(const Duration(milliseconds: 300), () {
      indicator.currentState?.show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }

  Scaffold pageMain(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        //toolbarHeight: 0,
        title: const Text("帳號列表")
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: RefreshIndicator(
                key: indicator,
                onRefresh: () => dioGetList(),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: resultList.length,
                  //shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () => selectItem(index),
                    child: Card(
                      margin: EdgeInsets.all(6),
                      color: (selectId!=index) ? Colors.white : Theme.of(context).primaryColorLight,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("帳號 : ${resultList[index]['account']}"),
                            Text("密碼 : ${resultList[index]['password']}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                  //padding: EdgeInsets.fromLTRB(16, 32, 16, 32),
                  //separatorBuilder: (BuildContext context, int index) => const Divider(),

                ),
              ),
            ),
            Container(
              height: selectId==-1? 0:80,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:     bottomWidget = Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            selectId==-1?"":"帳號 : ${resultList[selectId]['account']}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            selectId==-1?"":"密碼 : ${resultList[selectId]['password']}",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    OutlinedButton(
                      onPressed: ()=> startNewPageAndWait(),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Icon(Icons.edit),
                    ),
                  ],
                ),
              ),
            )
          ],
        )),
    );
  }

  void selectItem(int index){
    //int.parse(resultList[index]['id']);
    refreshUI(() => selectId = index);
  }

  startNewPageAndWait() async{
    //final bool result = await startNewPage(context, PageEditAccount(selectId: selectId));
    final result = await     Navigator.push(context,MaterialPageRoute(
        builder: (context) => PageEditAccount(selectId: int.parse(resultList[selectId]['id']))));

    print("回傳值: $result");
    indicator.currentState?.show();
  }

  Future<void> dioGetList() async {
    var response = await dioPostRequest("flutter/get_account_list.php",null);
    if(response == null) return;

    var code = response['code'];
    if(code == 200){
      resultList = response['data'];
    }
    refreshUI(null);
  }
}