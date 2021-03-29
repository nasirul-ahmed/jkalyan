import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firbaseUser = context.watch<User?>();
    return Drawer(
      child: Container(
        //decoration: BoxDecoration(color: Colors.blue[200]),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            GestureDetector(
              child: UserAccountsDrawerHeader(
                accountEmail: Text(
                  firbaseUser == null ? '' : '${firbaseUser.email}',
                  style: TextStyle(fontSize: 18),
                ),
                accountName: Text('Manager', style: TextStyle(fontSize: 20)),
                margin: EdgeInsets.zero,
                //padding: EdgeInsets.fromLTRB(0.0, 16.0, 150, 16.0),
                // currentAccountPicture: Image(
                //   //radius: 30.0,
                //   image: AssetImage('images/appstore.png'),
                // ),
                decoration: BoxDecoration(
                  color: Colors.blueGrey[600],
                  //shape: BoxShape.circle,
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: ListTile(
                leading: Icon(
                  Icons.pending_actions,
                  color: Colors.black,
                  size: 30,
                ),
                title: Text(
                  'Agent Deposits',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ),
            Divider(
              height: 1,
              color: Colors.white,
            ),
            Container(
              child: ListTile(
                onTap: () {
                  FirebaseAuth.instance.signOut();
                },
                title: Text(
                  'Log Out',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
            ),
            Container(
              child: Text(
                '@devbyNasirul',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
