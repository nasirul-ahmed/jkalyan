import 'package:devbynasirulahmed/screen/homepage/dashboard.dart';
import 'package:devbynasirulahmed/screen/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final firbaseUser = context.watch<User?>();
    //String uid = 'DRInLdEDXPTWrFva0ExbVNLdZ2t1';
    debugPrint(firbaseUser?.email);
    if (firbaseUser != null) {
      return DashBoard();
    } else
      return Login();
  }
}
