import 'package:shared_preferences/shared_preferences.dart';

class Helper{

  static String spIsLogIn = 'isloggedIn';

  static SharedPreferences? rememberMe;

  //for data save

  static Future<bool?> saveUserData(bool data) async {
    var preference = await SharedPreferences.getInstance();
    return preference.setBool(spIsLogIn, data);
  }
    //for data get

   static Future<bool?> getUserData() async{
     var preference = await SharedPreferences.getInstance();
    return preference.getBool(spIsLogIn) ?? false;
    }

    //for data clean

  static Future<void> rmClean() async {
    rememberMe = await SharedPreferences.getInstance();
    rememberMe!.remove(spIsLogIn);
  }
  }
