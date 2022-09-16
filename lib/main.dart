import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:helloworld/PageAccountList.dart';
import 'package:helloworld/PageRegister.dart';

import 'PageLogin.dart';
import 'PageMainMenu.dart';
import 'custom/LoadingDialog.dart';
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
      //debugShowCheckedModeBanner: false,
      theme: ThemeData(
        /* TODO 主題顏色，可以讓用戶設定 */
        primarySwatch: Colors.blue,
      ),
      home: PageLogin(),
    );
  }
}
