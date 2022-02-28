import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  // A string to store user id
  String _userId;
  // Constructor
  UserInfo(this._userId);
  // Get user id
  String get getUserId => _userId;

  // Update user id and store it in local
  void setUserId(String id) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("userId", id);
    _userId = id;
  }
}
