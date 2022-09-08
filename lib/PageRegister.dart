import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:helloworld/custom/ExpandToggleButtons.dart';
import 'package:dio/dio.dart';

class PageRegister extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PageRegisterState();
  }
}
class _PageRegisterState extends State<PageRegister>{

  final editAccount = TextEditingController();
  final editPassword = TextEditingController();
  var dropdownValue = 'ABC';
  var choiceChipValue = 'AAA';
  var toggleButtonValue = 0;

  @override
  Widget build(BuildContext context) {
    return pageMain(context);
  }

  Scaffold pageMain(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: const Text("註冊新會員")
      ),
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  shape: BoxShape.rectangle,
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 5,
                      color: Color(0x4D000000),
                      offset: Offset(0,2),
                    ),
                  ]
              ),
              child: Padding(
                padding: EdgeInsets.all(24.0),
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
                              borderRadius: BorderRadius.circular(8)
                          )
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20,bottom: 10),
                      child: TextField(
                        obscureText: true,
                        controller: editPassword,
                        decoration: InputDecoration(
                            labelText: '密碼',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8)
                            )
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        _choiceChip("AAA",true),
                        _choiceChip("BBB",false),
                        _choiceChip("CCC",false),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black26,
                        ),
                        child: _toggleButtons()
                      ),
                    ),
                    customToggle(),
                    ElevatedButton(
                      onPressed: () {
                        print("文本文字為: ${editAccount.text} | ${editPassword.text}");
                      },
                      child: Text("註冊"),
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ),
    );
  }

  Container customToggle() {
    var size = 5;
    var widget = List.generate(5, (index) => Expanded(child: Text("#$index")));
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        /*children: [
          TextButton(onPressed: (){print("1");}, child: Text("1")),
          TextButton(onPressed: (){print("1");}, child: Text("1")),
          TextButton(onPressed: (){print("1");}, child: Text("1")),
        ],*/
        children: _textButton()
      ),
    );
  }

  List<Widget> _textButton(){
    var size = 3;

    return List.generate(3, (index) =>
        Expanded(
          child: TextButton(
              onPressed: (){print("$index");},
              child: Text("#$index")
          ),
        )
    );
  }

  ExpandToggleButtons _toggleButtons(){
    var size = 5;
    var widget = List.generate(size, (index) =>
            Text("#$index")
    );
    return ExpandToggleButtons(
      borderRadius: BorderRadius.circular(24),
      onPressed: (index){
        setState(() {
          toggleButtonValue = index;
        });
      },
      isSelected: List.generate(size, (index) => index == toggleButtonValue),
      children: widget,
    );
  }

  ChoiceChip _choiceChip(String text, bool isSelected){
    return ChoiceChip(
      label: Text(text),
      selectedColor: Colors.blueAccent,
      disabledColor: Colors.greenAccent,
      onSelected: (bool value){
        setState(() {
          choiceChipValue = text;
        });
        print("$text");
      },
      selected: choiceChipValue == text,
    );
  }

  /* 用不太懂、而且不好看，暫時棄用 */
  /*DropdownButton _dropdownButton(){
    return DropdownButton<String>(
        value: dropdownValue,
        items: [
          _dropdownMenuItem("ABC"),
          _dropdownMenuItem("BBB"),
          _dropdownMenuItem("CCC"),
        ],
        onChanged: (val) {
          setState((){
            dropdownValue = val!;
            print("$val");
          });
        },
        hint: Text("123"),
    );
  }

  DropdownMenuItem<String> _dropdownMenuItem(String name){
    return DropdownMenuItem<String>(
      child: Text(name),
      value: name,
    );
  }*/
}