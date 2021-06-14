import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHandle {
  logOut(BuildContext context) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }
}
