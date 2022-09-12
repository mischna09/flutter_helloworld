

import 'package:dio/dio.dart';

class BaseDio{
  //單例模式
  static final BaseDio _instance = BaseDio._();
  BaseDio._();
  //static BaseDio getInstance() => _instance;
  static Dio getInstance() => _instance.dio;

  //請求通用設定
  final dio = Dio(BaseOptions(
    baseUrl: "https://c14game.000webhostapp.com/",
    connectTimeout: 5000,
    receiveTimeout: 100000,
    //contentType: Headers.jsonContentType,
    responseType: ResponseType.plain,
  ));
}