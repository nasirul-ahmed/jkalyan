import 'package:flutter/foundation.dart';

// class Auth {
//   final bool isLogged;
//   Auth(this.isLogged);
// }

class AuthNotifier extends ChangeNotifier {
  var _isLogged = false;

  bool get loggedIn => _isLogged;
  void isLogin() {
    _isLogged = true;
    print('logged in');
    notifyListeners();
  }

  logOut() {
    _isLogged = false;
    print('logged out');
    notifyListeners();
  }
}
