
class UserData{
  //單例模式
  static final UserData _instance = UserData._();
  UserData._();
  static UserData getInstance() => _instance;

  //用戶資料
  static String? id;
  static String? account;
  static String? password;
}