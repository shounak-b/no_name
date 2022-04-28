import 'package:shared_preferences/shared_preferences.dart';

class UserSharedPref {
  static SharedPreferences? sharedPreferences;
  static const String _uidKey = "userTokenKey";

  static Future init() async =>
      sharedPreferences = await SharedPreferences.getInstance();

  static Future setUserID(String uid) async {
    try {
      await sharedPreferences!.setString(_uidKey, uid);
    } catch (e) {
      print("setUserID: ${e.toString()}");
      Future.error("Something went wrong while"
          "\nsaving user data on device");
    }
  }

  static String? getUserID() {
    try {
      String? uid = sharedPreferences!.getString(_uidKey);
      return uid != null
          ? uid.isEmpty
              ? null
              : uid
          : null;
    } catch (e) {
      return null;
    }
  }
}
