import 'package:flutter/material.dart';
import 'package:helloworld/page/PageLogin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /* TODO 主題顏色，可以讓用戶設定 */
        primarySwatch: Colors.blue,
      ),
      home: PageLogin()
    );
  }
}
