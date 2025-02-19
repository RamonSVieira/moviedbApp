import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _username = '';

  String get username => _username;

  void setUsername(String newUsername) {
    _username = newUsername;
    notifyListeners();
  }
}
