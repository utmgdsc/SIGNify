import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  String _userId;
  UserInfo(this._userId);
  String get getUserId => _userId;

  void setUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userId", id);
    _userId = id;
  }
}
