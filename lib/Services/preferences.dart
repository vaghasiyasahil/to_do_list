import 'package:shared_preferences/shared_preferences.dart';

class preferences{
  static late SharedPreferences prefs;
  static Future<void> iniMemory() async {
    prefs= await SharedPreferences.getInstance();
  }

  static void setUserLoginStatus(bool isLogin){
    prefs.setBool("isLogin", isLogin);
  }
  static Future<bool> getUserLoginStatus() async {
    return await prefs.getBool("isLogin")??false;
  }

  static void setUserEmail(String email){
    prefs.setString("user", email);
  }
  static Future<String> getUserEmail() async {
    return await prefs.getString("user")??'';
  }

}